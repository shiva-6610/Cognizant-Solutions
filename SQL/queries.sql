-- 1. User Upcoming Events
-- Show upcoming events a user registered for in their city

SELECT 
    u.full_name,
    e.title AS event_name,
    e.city,
    e.start_date,
    e.status
FROM Users u
JOIN Registrations r 
    ON u.user_id = r.user_id
JOIN Events e 
    ON r.event_id = e.event_id
WHERE e.status = 'upcoming'
AND u.city = e.city
ORDER BY e.start_date;


-- 2. Top Rated Events
-- Events with highest average rating having at least 10 feedbacks

SELECT 
    e.event_id,
    e.title,
    AVG(f.rating) AS average_rating,
    COUNT(f.feedback_id) AS total_feedbacks
FROM Events e
JOIN Feedback f 
    ON e.event_id = f.event_id
GROUP BY e.event_id, e.title
HAVING COUNT(f.feedback_id) >= 10
ORDER BY average_rating DESC;


-- 3. Inactive Users
-- Users who did not register for any events in last 90 days

SELECT 
    u.user_id,
    u.full_name,
    u.email
FROM Users u
LEFT JOIN Registrations r 
    ON u.user_id = r.user_id
GROUP BY u.user_id, u.full_name, u.email
HAVING MAX(r.registration_date) < CURDATE() - INTERVAL 90 DAY
OR MAX(r.registration_date) IS NULL;


-- 4. Peak Session Hours
-- Sessions scheduled between 10 AM and 12 PM for each event

SELECT 
    e.title AS event_name,
    COUNT(s.session_id) AS sessions_between_10_and_12
FROM Events e
JOIN Sessions s 
    ON e.event_id = s.event_id
WHERE TIME(s.start_time) BETWEEN '10:00:00' AND '12:00:00'
GROUP BY e.event_id, e.title;


-- 5. Most Active Cities
-- Top 5 cities with highest distinct user registrations

SELECT 
    u.city,
    COUNT(DISTINCT r.user_id) AS total_registrations
FROM Users u
JOIN Registrations r 
    ON u.user_id = r.user_id
GROUP BY u.city
ORDER BY total_registrations DESC
LIMIT 5;


-- 6. Event Resource Summary
-- Count of PDFs, images, and links for each event

SELECT 
    e.title AS event_name,
    r.resource_type,
    COUNT(r.resource_id) AS total_resources
FROM Events e
JOIN Resources r 
    ON e.event_id = r.event_id
GROUP BY e.title, r.resource_type
ORDER BY e.title;


-- 7. Low Feedback Alerts
-- Users who gave rating less than 3

SELECT 
    u.full_name,
    e.title AS event_name,
    f.rating,
    f.comments
FROM Feedback f
JOIN Users u 
    ON f.user_id = u.user_id
JOIN Events e 
    ON f.event_id = e.event_id
WHERE f.rating < 3;


-- 8. Sessions per Upcoming Event
-- Count sessions for upcoming events

SELECT 
    e.title AS event_name,
    COUNT(s.session_id) AS total_sessions
FROM Events e
LEFT JOIN Sessions s 
    ON e.event_id = s.event_id
WHERE e.status = 'upcoming'
GROUP BY e.event_id, e.title;


-- 9. Organizer Event Summary
-- Number of events organized with status

SELECT 
    u.full_name AS organizer_name,
    e.status,
    COUNT(e.event_id) AS total_events
FROM Users u
JOIN Events e 
    ON u.user_id = e.organizer_id
GROUP BY u.full_name, e.status
ORDER BY u.full_name;


-- 10. Feedback Gap
-- Events that have registrations but no feedback

SELECT DISTINCT
    e.event_id,
    e.title
FROM Events e
JOIN Registrations r
    ON e.event_id = r.event_id
LEFT JOIN Feedback f
    ON e.event_id = f.event_id
WHERE f.feedback_id IS NULL;


-- 11. Daily New User Count
-- Users registered each day in the last 7 days

SELECT 
    registration_date,
    COUNT(user_id) AS total_users
FROM Users
WHERE registration_date >= CURDATE() - INTERVAL 7 DAY
GROUP BY registration_date
ORDER BY registration_date;


-- 12. Event with Maximum Sessions
-- Event(s) having highest number of sessions

SELECT 
    e.event_id,
    e.title,
    COUNT(s.session_id) AS total_sessions
FROM Events e
JOIN Sessions s
    ON e.event_id = s.event_id
GROUP BY e.event_id, e.title
HAVING COUNT(s.session_id) = (
    SELECT MAX(session_count)
    FROM (
        SELECT COUNT(session_id) AS session_count
        FROM Sessions
        GROUP BY event_id
    ) AS temp
);


-- 13. Average Rating per City
-- Average feedback rating for events in each city

SELECT 
    e.city,
    ROUND(AVG(f.rating), 2) AS average_rating
FROM Events e
JOIN Feedback f
    ON e.event_id = f.event_id
GROUP BY e.city;


-- 14. Most Registered Events
-- Top 3 events with highest registrations

SELECT 
    e.event_id,
    e.title,
    COUNT(r.registration_id) AS total_registrations
FROM Events e
JOIN Registrations r
    ON e.event_id = r.event_id
GROUP BY e.event_id, e.title
ORDER BY total_registrations DESC
LIMIT 3;


-- 15. Event Session Time Conflict
-- Overlapping sessions within same event

SELECT 
    s1.event_id,
    s1.title AS session1,
    s2.title AS session2,
    s1.start_time,
    s1.end_time,
    s2.start_time,
    s2.end_time
FROM Sessions s1
JOIN Sessions s2
    ON s1.event_id = s2.event_id
    AND s1.session_id < s2.session_id
WHERE s1.start_time < s2.end_time
AND s1.end_time > s2.start_time;


-- 16. Unregistered Active Users
-- Users created in last 30 days but not registered

SELECT 
    u.user_id,
    u.full_name,
    u.registration_date
FROM Users u
LEFT JOIN Registrations r
    ON u.user_id = r.user_id
WHERE u.registration_date >= CURDATE() - INTERVAL 30 DAY
AND r.registration_id IS NULL;


-- 17. Multi-Session Speakers
-- Speakers handling more than one session

SELECT 
    speaker_name,
    COUNT(session_id) AS total_sessions
FROM Sessions
GROUP BY speaker_name
HAVING COUNT(session_id) > 1;


-- 18. Resource Availability Check
-- Events without resources

SELECT 
    e.event_id,
    e.title
FROM Events e
LEFT JOIN Resources r
    ON e.event_id = r.event_id
WHERE r.resource_id IS NULL;


-- 19. Completed Events with Feedback Summary
-- Completed events with registrations and average rating

SELECT 
    e.title,
    COUNT(DISTINCT r.registration_id) AS total_registrations,
    ROUND(AVG(f.rating), 2) AS average_rating
FROM Events e
LEFT JOIN Registrations r
    ON e.event_id = r.event_id
LEFT JOIN Feedback f
    ON e.event_id = f.event_id
WHERE e.status = 'completed'
GROUP BY e.event_id, e.title;


-- 20. User Engagement Index
-- Events attended and feedbacks submitted by each user

SELECT 
    u.user_id,
    u.full_name,
    COUNT(DISTINCT r.event_id) AS events_attended,
    COUNT(DISTINCT f.feedback_id) AS feedbacks_given
FROM Users u
LEFT JOIN Registrations r
    ON u.user_id = r.user_id
LEFT JOIN Feedback f
    ON u.user_id = f.user_id
GROUP BY u.user_id, u.full_name;


-- 21. Top Feedback Providers
-- Top 5 users with most feedback entries

SELECT 
    u.full_name,
    COUNT(f.feedback_id) AS total_feedbacks
FROM Users u
JOIN Feedback f
    ON u.user_id = f.user_id
GROUP BY u.user_id, u.full_name
ORDER BY total_feedbacks DESC
LIMIT 5;


-- 22. Duplicate Registrations Check
-- Users registered more than once for same event

SELECT 
    user_id,
    event_id,
    COUNT(*) AS duplicate_count
FROM Registrations
GROUP BY user_id, event_id
HAVING COUNT(*) > 1;


-- 23. Registration Trends
-- Month-wise registration count for past 12 months

SELECT 
    DATE_FORMAT(registration_date, '%Y-%m') AS month,
    COUNT(registration_id) AS total_registrations
FROM Registrations
WHERE registration_date >= CURDATE() - INTERVAL 12 MONTH
GROUP BY DATE_FORMAT(registration_date, '%Y-%m')
ORDER BY month;


-- 24. Average Session Duration per Event
-- Average duration of sessions in minutes for each event

SELECT 
    e.event_id,
    e.title AS event_name,
    ROUND(AVG(
        TIMESTAMPDIFF(MINUTE, s.start_time, s.end_time)
    ), 2) AS average_session_duration_minutes
FROM Events e
JOIN Sessions s
    ON e.event_id = s.event_id
GROUP BY e.event_id, e.title;


-- 25. Events Without Sessions
-- Events having no sessions scheduled

SELECT 
    e.event_id,
    e.title
FROM Events e
LEFT JOIN Sessions s
    ON e.event_id = s.event_id
WHERE s.session_id IS NULL;