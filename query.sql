INSERT INTO `catalog_product_index_eav_tmp` SELECT
	`pid`.`entity_id`,
	`pid`.`attribute_id`,
	`pid`.`store_id`,
	IFNULL(pis.value, pid.value) AS `value`
FROM
	(
		SELECT
			`s`.`store_id`,
			`s`.`website_id`,
			`d`.`entity_id`,
			`d`.`attribute_id`,
			`d`.`value`
		FROM
			`core_store` AS `s`
		LEFT JOIN `catalog_product_entity_int` AS `d` ON 1 = 1
		AND d.store_id = 0
		WHERE
			(s.store_id != 0)
	) AS `pid`
LEFT JOIN `catalog_product_entity_int` AS `pis` ON pis.entity_id = pid.entity_id
AND pis.attribute_id = pid.attribute_id
AND pis.store_id = pid.store_id
INNER JOIN `cataloginventory_stock_status` AS `ciss` ON ciss.product_id = pid.entity_id
AND ciss.website_id = pid.website_id
WHERE
	(
		pid.attribute_id IN (
			'75',
			'85',
			'156',
			'157',
			'159',
			'173'
		)
	)
AND (
	IFNULL(pis.value, pid.value) IS NOT NULL
)
AND (pid.entity_id IN('132510'))
AND (ciss.stock_status = 1)
