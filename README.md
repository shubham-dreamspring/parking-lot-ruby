# Parking Lot

## Usage
### Help
```
ruby app.rb -h | --help
```
### Park Car
```
ruby app.rb -p | --park REGISTRATION_NUMBER
```
### Unpark Car
```
ruby app.rb -u | --unpark REGISTRATION_NUMBER
```
### Get all the cars in parking lot
```
ruby app.rb -c | --cars
```

### Get all the invoices
```
ruby app.rb -i | --invoice
```
### Get the invoice by invoice id
```
ruby app.rb -i | --invoice INVOICE_ID
```

### For test env
```
MODE="test" ruby app.rb -i | --invoice INVOICE_ID
MODE="test" ruby app.rb -p | --park REGISTRATION_NUMBER
MODE="test" ruby app.rb -u | --unpark REGISTRATION_NUMBER
MODE="test" ruby app.rb -c | --car
```
