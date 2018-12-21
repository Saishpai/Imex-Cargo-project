CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `imex_cargo`.`master_view` AS
    SELECT 
        `c`.`customer_id` AS `customer_id`,
        `o`.`order_id` AS `order_id`,
        `cg`.`cargo_id` AS `cargo_id`,
        `c`.`First_name` AS `First_name`,
        `c`.`Last_name` AS `Last_name`,
        `c`.`company_name` AS `company_name`,
        `c`.`contact_number` AS `contact_number`,
        `o`.`Ready_date` AS `Ready_date`,
        `o`.`max_arrival_date` AS `max_arrival_date`,
        `f`.`awb` AS `awb`,
        `f`.`flight_number` AS `flight_number`
    FROM
        (((((`imex_cargo`.`customer` `c`
        JOIN `imex_cargo`.`orders` `o` ON ((`c`.`customer_id` = `o`.`customer_id`)))
        JOIN `imex_cargo`.`cargo` `cg` ON ((`o`.`order_id` = `cg`.`order_id`)))
        JOIN `imex_cargo`.`cargo_flight_tbl` `cft` ON ((`cg`.`cargo_id` = `cft`.`cargo_id`)))
        JOIN `imex_cargo`.`flight` `f` ON ((`cft`.`flight_id` = `f`.`flight_id`)))
        JOIN `imex_cargo`.`invoice` `i` ON ((`c`.`customer_id` = `i`.`customer_id`)))