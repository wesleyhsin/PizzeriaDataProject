-- Joining the item, address table to the orders table

SELECT o.order_id, i.item_price, o.quantity, i.item_cat, i.item_name, 
o.created_at, a.delivery_address1, a.delivery_address2, a.delivery_city, 
a.delivery_zipcode, o.delivery
FROM orders2 o
LEFT JOIN item i on o.item_id = i.item_id
LEFT JOIN address a on o.add_id = a.add_id
;

-- Produce the total quantity by ingredient
	-- Joining item, recipe, ingredient table to orders

SELECT 
	s1.item_name, 
	s1.ing_id, 
    s1.ing_name, 
	s1.ing_weight, s1.ing_price, 
	s1.order_quantity, s1.recipe_quantity,
	s1.order_quantity * recipe_quantity as ordered_weight,
    s1.ing_price/s1.ing_weight as unit_cost,
    (s1.order_quantity*s1.recipe_quantity)*(s1.ing_price/s1.ing_weight) as ingredient_cost
FROM 
(SELECT 
	o.item_id, 
    i.sku,
	i.item_name, 
	ing.ing_name,
	r.ing_id, r.quantity as recipe_quantity,
	sum(o.quantity) as order_quantity,
    ing.ing_weight,
    ing.ing_price
FROM orders2 o
LEFT JOIN item i on o.item_id = i.item_id
LEFT JOIN recipe r on i.sku = r.recipe_id
LEFT JOIN ingredient ing on ing.ing_id = r.ing_id
GROUP BY 
	o.item_id, 
	i.sku, 
    i.item_name, 
    r.ing_id, 
    r.quantity, 
    ing.ing_name, 
    ing.ing_weight, 
    ing.ing_price
) s1
;

-- Creating a VIEW
Create VIEW stock1 as
SELECT 
	s1.item_name, 
	s1.ing_id, 
    s1.ing_name, 
	s1.ing_weight, s1.ing_price, 
	s1.order_quantity, s1.recipe_quantity,
	s1.order_quantity * recipe_quantity as ordered_weight,
    s1.ing_price/s1.ing_weight as unit_cost,
    (s1.order_quantity*s1.recipe_quantity)*(s1.ing_price/s1.ing_weight) as ingredient_cost
FROM 
(SELECT 
	o.item_id, 
    i.sku,
	i.item_name, 
	ing.ing_name,
	r.ing_id, r.quantity as recipe_quantity,
	sum(o.quantity) as order_quantity,
    ing.ing_weight,
    ing.ing_price
FROM orders2 o
LEFT JOIN item i on o.item_id = i.item_id
LEFT JOIN recipe r on i.sku = r.recipe_id
LEFT JOIN ingredient ing on ing.ing_id = r.ing_id
GROUP BY 
	o.item_id, 
	i.sku, 
    i.item_name, 
    r.ing_id, 
    r.quantity, 
    ing.ing_name, 
    ing.ing_weight, 
    ing.ing_price
) s1
;
-- Calculate Total Weight ordered, inventory amount, Inventory remaining per ingredient
SELECT 
	s2.ing_name,
    s2.ordered_weight,
    ing.ing_weight*inv.quantity as total_inv_weight,
    (ing.ing_weight * inv.quantity)-s2.ordered_weight as remaining_weight
FROM
(SELECT
	ing_id,
	ing_name,
    sum(ordered_weight) as ordered_weight
FROM stock1
GROUP BY ing_name, ing_id) s2
LEFT JOIN inventory inv on inv.item_id = s2.ing_id
LEFT JOIN ingredient ing on ing.ing_id = s2.ing_id
;

-- Staff, rota, shift
-- using timediff to find the minutes difference between end time and start time then divide by 60 and then multiply by the hourly rate
SELECT
	r.date,
    s.first_name,
    s.last_name,
    s.hourly_rate,
    sh.start_time,
    sh.end_time,
    ((hour(timediff(sh.end_time,sh.start_time))*60)+(minute(timediff(sh.end_time,sh.start_time))))/60 as hours_in_shift,
	((hour(timediff(sh.end_time,sh.start_time))*60)+(minute(timediff(sh.end_time,sh.start_time))))/60 * s.hourly_rate as staff_cost
FROM rota2 r
LEFT JOIN staff s on r.staff_id = s.staff_id
LEFT JOIN shift sh on r.shift_id = sh.shift_id







