-- 1. Проверяем количество строк
SELECT COUNT(*) AS total_rows
FROM telecom_churn_raw;

-- 2. Проверяем распределение оттока
SELECT
    churn,
    COUNT(*) AS customers
FROM telecom_churn_raw
GROUP BY churn
ORDER BY churn;

-- 3. Проверяем пропуски и пустые строки
SELECT
    COUNT(*) FILTER (
        WHERE state IS NULL OR TRIM(state) = ''
    ) AS missing_state,
    COUNT(*) FILTER (
        WHERE account_length IS NULL OR TRIM(account_length) = ''
    ) AS missing_account_length,
    COUNT(*) FILTER (
        WHERE area_code IS NULL OR TRIM(area_code) = ''
    ) AS missing_area_code,
    COUNT(*) FILTER (
        WHERE international_plan IS NULL OR TRIM(international_plan) = ''
    ) AS missing_international_plan,
    COUNT(*) FILTER (
        WHERE voice_mail_plan IS NULL OR TRIM(voice_mail_plan) = ''
    ) AS missing_voice_mail_plan,
    COUNT(*) FILTER (
        WHERE number_vmail_messages IS NULL OR TRIM(number_vmail_messages) = ''
    ) AS missing_number_vmail_messages,
    COUNT(*) FILTER (
        WHERE total_day_minutes IS NULL OR TRIM(total_day_minutes) = ''
    ) AS missing_total_day_minutes,
    COUNT(*) FILTER (
        WHERE total_day_calls IS NULL OR TRIM(total_day_calls) = ''
    ) AS missing_total_day_calls,
    COUNT(*) FILTER (
        WHERE total_day_charge IS NULL OR TRIM(total_day_charge) = ''
    ) AS missing_total_day_charge,
    COUNT(*) FILTER (
        WHERE total_eve_minutes IS NULL OR TRIM(total_eve_minutes) = ''
    ) AS missing_total_eve_minutes,
    COUNT(*) FILTER (
        WHERE total_eve_calls IS NULL OR TRIM(total_eve_calls) = ''
    ) AS missing_total_eve_calls,
    COUNT(*) FILTER (
        WHERE total_eve_charge IS NULL OR TRIM(total_eve_charge) = ''
    ) AS missing_total_eve_charge,
    COUNT(*) FILTER (
        WHERE total_night_minutes IS NULL OR TRIM(total_night_minutes) = ''
    ) AS missing_total_night_minutes,
    COUNT(*) FILTER (
        WHERE total_night_calls IS NULL OR TRIM(total_night_calls) = ''
    ) AS missing_total_night_calls,
    COUNT(*) FILTER (
        WHERE total_night_charge IS NULL OR TRIM(total_night_charge) = ''
    ) AS missing_total_night_charge,
    COUNT(*) FILTER (
        WHERE total_intl_minutes IS NULL OR TRIM(total_intl_minutes) = ''
    ) AS missing_total_intl_minutes,
    COUNT(*) FILTER (
        WHERE total_intl_calls IS NULL OR TRIM(total_intl_calls) = ''
    ) AS missing_total_intl_calls,
    COUNT(*) FILTER (
        WHERE total_intl_charge IS NULL OR TRIM(total_intl_charge) = ''
    ) AS missing_total_intl_charge,
    COUNT(*) FILTER (
        WHERE customer_service_calls IS NULL OR TRIM(customer_service_calls) = ''
    ) AS missing_customer_service_calls,
    COUNT(*) FILTER (
        WHERE churn IS NULL OR TRIM(churn) = ''
    ) AS missing_churn
FROM telecom_churn_raw;

-- 4. Проверяем значения категориальных столбцов
SELECT
    'international_plan' AS column_name,
    international_plan AS value,
    COUNT(*) AS rows_count
FROM telecom_churn_raw
GROUP BY international_plan

UNION ALL

SELECT
    'voice_mail_plan',
    voice_mail_plan,
    COUNT(*)
FROM telecom_churn_raw
GROUP BY voice_mail_plan

UNION ALL

SELECT
    'churn',
    churn,
    COUNT(*)
FROM telecom_churn_raw
GROUP BY churn

ORDER BY column_name, value;

-- 5. Проверяем дубликаты строк
SELECT
    COUNT(*) - COUNT(DISTINCT (
        state,
        account_length,
        area_code,
        international_plan,
        voice_mail_plan,
        number_vmail_messages,
        total_day_minutes,
        total_day_calls,
        total_day_charge,
        total_eve_minutes,
        total_eve_calls,
        total_eve_charge,
        total_night_minutes,
        total_night_calls,
        total_night_charge,
        total_intl_minutes,
        total_intl_calls,
        total_intl_charge,
        customer_service_calls,
        churn
    )) AS duplicate_rows
FROM telecom_churn_raw;

-- 6. Проверяем числовые диапазоны
SELECT
    MIN(account_length::INTEGER) AS min_account_length,
    MAX(account_length::INTEGER) AS max_account_length,
    MIN(total_day_minutes::NUMERIC) AS min_day_minutes,
    MAX(total_day_minutes::NUMERIC) AS max_day_minutes,
    MIN(customer_service_calls::INTEGER) AS min_service_calls,
    MAX(customer_service_calls::INTEGER) AS max_service_calls
FROM telecom_churn_raw;
