REPLACE INTO `reward_leaderboard` (
	`user_id`,
	`leaderboardtype_id`,
	`total_points`,
	`week_points`,
	`created_at`,
	`updated_at`
) (SELECT
	`re`.`user_id`,
	`rlat`.`leaderboardtype_id`,
	SUM(`re`.`points`),
	SUM(CASE WHEN ADDDATE( `re`.`created_at`, INTERVAL 1 WEEK ) > NOW() THEN  `re`.`points` ELSE 0 END),
	NOW(),
	NOW()
FROM
	`reward_event` AS `re`,
	`reward_action_leaderboard_type` AS `rlat`
WHERE
	`re`.`action_id` = `rlat`.`action_id`
GROUP BY
	`re`.`user_id`,
	`rlat`.`leaderboardtype_id`
);
