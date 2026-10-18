CREATE TABLE telecom_churn_clean AS
SELECT
    state,
    account_length::INTEGER AS account_length,
    area_code::INTEGER AS area_code,
    CASE
        WHEN international_plan = 'Yes' THEN TRUE
        WHEN international_plan = 'No' THEN FALSE
    END AS international_plan,
    CASE
        WHEN voice_mail_plan = 'Yes' THEN TRUE
        WHEN voice_mail_plan = 'No' THEN FALSE
    END AS voice_mail_plan,
    number_vmail_messages::INTEGER AS number_vmail_messages,
    total_day_minutes::NUMERIC(6, 1) AS total_day_minutes,
    total_day_calls::INTEGER AS total_day_calls,
    total_day_charge::NUMERIC(7, 2) AS total_day_charge,
    total_eve_minutes::NUMERIC(6, 1) AS total_eve_minutes,
    total_eve_calls::INTEGER AS total_eve_calls,
    total_eve_charge::NUMERIC(7, 2) AS total_eve_charge,
    total_night_minutes::NUMERIC(6, 1) AS total_night_minutes,
    total_night_calls::INTEGER AS total_night_calls,
    total_night_charge::NUMERIC(7, 2) AS total_night_charge,
    total_intl_minutes::NUMERIC(6, 1) AS total_intl_minutes,
    total_intl_calls::INTEGER AS total_intl_calls,
    total_intl_charge::NUMERIC(7, 2) AS total_intl_charge,
    customer_service_calls::INTEGER AS customer_service_calls,
    churn::BOOLEAN AS churn
FROM telecom_churn_raw;
