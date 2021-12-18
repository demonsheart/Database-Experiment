DELIMITER //
CREATE DEFINER = CURRENT_USER FUNCTION get_car_per_price(car_id int,  billed_type enum('hour','day'))
RETURNS FLOAT
  READS SQL DATA
  SQL SECURITY INVOKER
BEGIN
		DECLARE per_price FLOAT;
		SET per_price = 0;

		IF billed_type = 'hour' THEN
		SELECT price_per_hour INTO per_price FROM cars WHERE car_id = car_id;
		ELSEIF billed_type = 'day' THEN
		SELECT price_per_day INTO per_price FROM cars WHERE car_id = car_id;
		END IF;
		
		RETURN per_price;
END; //
DELIMITER ;

DROP FUNCTION get_car_per_price;