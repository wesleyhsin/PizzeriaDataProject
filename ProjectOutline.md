# PizzeriaDataProject
Task: Develop a relational database for a client's pizzeria to store customer and order data efficiently, followed by creating an interactive dashboard for visualizing the information.

Main area of focus
- Orders
- Stock control
- Staff

Orders Data Required
- Item name
- Item price
- Quantity
- Customer name
- Delivery Address
Additional fields to consider:OrderID, Size(of pizza), Category(snacks, beverage, sides etc)


# What we need to create a database
- RowID
- OrderID
- Item name
- Item category
- Item size
- Item price
- Quantity
- Customer first name
- Customer last name
- Delivery address 1
- Delivery address 2
- Delivery city
- Delivery zip code

# Stock control requirements
- Wants to be able to know when it's time to order new stock
- Need information on
    - what ingredients go into each pizza
    - their quantity based on the size of the pizza
    - the existing stock level
- Assuming the delivery time for supplies are all the same in this scenario
# Staff data requirements
- Wants to know which staff members are working when
- Based on the staff salary info, how much each pizza costs (ingredients + chefs + delivery)
--------------------------------------------------------------------------------------------------
# Using QuickDBD to layout database

![QuickDBD-Pizza Database](https://github.com/wesleyhsin/PizzeriaDataProject/assets/156386124/867fc7be-6a35-44dc-b412-f2658f9b8115)

# Imported all Spreadsheets into MySql Workbench for SQL Analysis


# Dashboard 1 - Order activity
Need the following
- Total orders
- Total sales
- total items
- Average order value
- Sales by category
- Top selling items
- Orders by hour
- Sales by hour
- Orders by address
- Orders by delivery/pick up

# Dashboard 2 - Inventory Management
- Need to calculate how much inventory we're using and then identify inventory that needs reordering.
- Calculate how much each pizza costs to make based on cost of ingredients
Need:
    - Total quantity by ingredient
    - Total cost of ingredients
    - Calculated cost of pizza
    - Percentage stock remaining by ingredient
