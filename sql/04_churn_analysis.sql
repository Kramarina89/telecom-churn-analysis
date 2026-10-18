-- 1. Сравним отток по международному тарифу
SELECT
    international_plan,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE churn = TRUE) AS churned_customers,
    ROUND(
        COUNT(*) FILTER (WHERE churn = TRUE) * 100.0 / COUNT(*),
        2
    ) AS churn_rate_pct
FROM telecom_churn_clean
GROUP BY international_plan
ORDER BY international_plan;

-- 2. Сравним отток по голосовой почте
SELECT
    voice_mail_plan,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE churn = TRUE) AS churned_customers,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE churn = TRUE) / COUNT(*),
        2
    ) AS churn_rate_pct
FROM telecom_churn_clean
GROUP BY voice_mail_plan
ORDER BY voice_mail_plan;

-- 3. Сравним отток в зависимости от обращений в поддержку
SELECT
    customer_service_calls,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE churn = TRUE) AS churned_customers,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE churn = TRUE) / COUNT(*),
        2
    ) AS churn_rate_pct
FROM telecom_churn_clean
GROUP BY customer_service_calls
ORDER BY customer_service_calls;

-- 4. Сравним расходы на международные звонки в зависимости от оттока
SELECT
    churn,
    COUNT(*) AS total_customers,
    ROUND(AVG(total_intl_charge), 2) AS avg_intl_charge,
    ROUND(AVG(total_intl_minutes), 2) AS avg_intl_minutes,
    ROUND(AVG(total_intl_calls), 2) AS avg_intl_calls
FROM telecom_churn_clean
GROUP BY churn
ORDER BY churn;

-- 5. Сравним дневные показатели в зависимости от оттока
SELECT
    churn,
    COUNT(*) AS total_customers,
    ROUND(AVG(total_day_charge), 2) AS avg_day_charge,
    ROUND(AVG(total_day_minutes), 2) AS avg_day_minutes,
    ROUND(AVG(total_day_calls), 2) AS avg_day_calls
FROM telecom_churn_clean
GROUP BY churn
ORDER BY churn;