# Rails Engine

Rails Engine is a Rails-based API that allows a client to access business intelligence and see relationships in e-commerce data.

## Installation

Rails Engine uses Ruby 2.3.0 and Rails 5.0.1. Run the command `bundle install` to install neccesary gems.

## Database

To create the database, run the commands `rake db:create` and `rake db:migrate`.

Data can be imported into the database from CSVs using the command `rake seed_database`.  
The CSV files must be placed in the subdirectory called `seed` inside `db`.  
The files can be individually imported with the commands
  + `seed_database:import_customers`
  + `seed_database:import_merchants`
  + `seed_database:import_invoices`
  + `seed_database:import_items`
  + `seed_database:import_invoice_items`
  + `seed_database:import_transactions`

## Testing

Use the command `rspec` to run the test suite.

## Services

### Record Endpoints

* `GET /api/v1/merchants.json` returns an index of all merchants
* `GET /api/v1/merchants/1.json` returns the merchant with an ID of 1
* `GET /api/v1/merchants/find.json?name=Wamaht` returns the merchant with a name of Wamaht
  + Note: This will work to find a record by any parameter that is associated with that record.
* `GET /api/v1/merchants/find_all.json?name=Wamaht` returns all merchants named Wamaht

### Relationship Endpoints

#### Merchants

* `GET /api/v1/merchants/:id/items` returns a collection of items associated with that merchant
* `GET /api/v1/merchants/:id/invoices` returns a collection of invoices associated with that merchant from their known orders

#### Invoices

* `GET /api/v1/invoices/:id/transactions` returns a collection of associated transactions
* `GET /api/v1/invoices/:id/invoice_items` returns a collection of associated invoice items
* `GET /api/v1/invoices/:id/items` returns a collection of associated items
* `GET /api/v1/invoices/:id/customer` returns the associated customer
* `GET /api/v1/invoices/:id/merchant` returns the associated merchant

#### Invoice Items

* `GET /api/v1/invoice_items/:id/invoice` returns the associated invoice
* `GET /api/v1/invoice_items/:id/item` returns the associated item

#### Items

* `GET /api/v1/items/:id/invoice_items` returns a collection of associated invoice items
* `GET /api/v1/items/:id/merchant` returns the associated merchant

#### Transactions

* `GET /api/v1/transactions/:id/invoice` returns the associated invoice

#### Customers

* `GET /api/v1/customers/:id/invoices` returns a collection of associated invoices
* `GET /api/v1/customers/:id/transactions` returns a collection of associated transactions

### Business Intelligence Endpoints

#### All Merchants

* `GET /api/v1/merchants/most_revenue?quantity=x` returns the top `x` merchants ranked by total revenue
* `GET /api/v1/merchants/most_items?quantity=x` returns the top `x` merchants ranked by total number of items sold
* `GET /api/v1/merchants/revenue?date=x` returns the total revenue for date `x` across all merchants

#### Single Merchant

* `GET /api/v1/merchants/:id/revenue` returns the total revenue for that merchant across all transactions
* `GET /api/v1/merchants/:id/revenue?date=x` returns the total revenue for that merchant for a specific invoice date `x`
* `GET /api/v1/merchants/:id/favorite_customer` returns the customer who has conducted the most total number of successful transactions.
* `GET /api/v1/merchants/:id/customers_with_pending_invoices` returns a collection of customers which have pending (unpaid) invoices

#### Items

* `GET /api/v1/items/most_revenue?quantity=x` returns the top `x` items ranked by total revenue generated
* `GET /api/v1/items/most_items?quantity=x` returns the top `x` item instances ranked by total number sold
* `GET /api/v1/items/:id/best_day` returns the date with the most sales for the given item using the invoice date. If there are multiple days with equal number of sales, return the most recent day.

#### Customers

* `GET /api/v1/customers/:id/favorite_merchant` returns a merchant where the customer has conducted the most successful transactions

## Authors
Brendan Dillon  
Ryan Workman
