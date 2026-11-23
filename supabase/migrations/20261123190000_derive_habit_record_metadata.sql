CREATE OR REPLACE FUNCTION public.derive_habit_record_metadata()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = pg_catalog, public
AS $$
DECLARE
  joined_habit public.user_habits%ROWTYPE;
BEGIN
  IF auth.uid() IS NULL OR NEW.user_id IS DISTINCT FROM auth.uid() THEN
    RAISE EXCEPTION 'Habit record owner does not match the authenticated user'
      USING ERRCODE = '42501';
  END IF;

  SELECT *
  INTO joined_habit
  FROM public.user_habits
  WHERE id = NEW.user_habit_id
    AND user_id = NEW.user_id
  FOR UPDATE;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Joined habit does not exist or is not owned by the user'
      USING ERRCODE = '42501';
  END IF;

  NEW.habit_id := joined_habit.habit_id;
  NEW.frequency_label := CASE
    WHEN joined_habit.target_count > 0
      AND joined_habit.target_period IN ('day', 'week', 'month', 'year')
    THEN translate(
      joined_habit.target_count::text,
      '0123456789',
      '۰۱۲۳۴۵۶۷۸۹'
    ) || ' بار در ' || CASE joined_habit.target_period
      WHEN 'day' THEN 'روز'
      WHEN 'week' THEN 'هفته'
      WHEN 'month' THEN 'ماه'
      WHEN 'year' THEN 'سال'
    END
    ELSE CASE joined_habit.frequency_type
      WHEN 'daily' THEN 'روزانه'
      WHEN 'weekly' THEN 'هفتگی'
      WHEN 'monthly' THEN 'ماهانه'
      ELSE 'بر اساس برنامه شخصی'
    END
  END;

  SELECT COALESCE(MAX(record_number), 0) + 1
  INTO NEW.record_number
  FROM public.habit_records
  WHERE user_habit_id = joined_habit.id;

  RETURN NEW;
END;
$$;

REVOKE ALL ON FUNCTION public.derive_habit_record_metadata()
  FROM PUBLIC, anon, authenticated;

DROP TRIGGER IF EXISTS zzzz_habit_records_derive_metadata
  ON public.habit_records;

CREATE TRIGGER zzzz_habit_records_derive_metadata
BEFORE INSERT ON public.habit_records
FOR EACH ROW
EXECUTE FUNCTION public.derive_habit_record_metadata();
