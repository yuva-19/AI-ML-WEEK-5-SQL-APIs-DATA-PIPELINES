import pandas as pd

#
customers = pd.read_csv('07_Data_Collection_Pipelines/04_Combining_Multiple_Sources/customers.csv')
orders = pd.read_csv('07_Data_Collection_Pipelines/04_Combining_Multiple_Sources/orders.csv')
orders_jan = pd.read_csv('07_Data_Collection_Pipelines/04_Combining_Multiple_Sources/orders_jan.csv')
orders_feb = pd.read_csv('07_Data_Collection_Pipelines/04_Combining_Multiple_Sources/orders_feb.csv')
customers_api = pd.read_csv('07_Data_Collection_Pipelines/04_Combining_Multiple_Sources/customers_api.csv')

#
result = pd.merge(
    customers,
    orders,
    on = 'customer_id'
)

print(result)
print()

#

result = customers.set_index('customer_id').join(
    orders.set_index('customer_id'),
    on = 'customer_id'
)

print(result)


# 
print()
result = pd.concat(
    [orders_jan,orders_feb],
    ignore_index= True
)
print(result[result.duplicated(keep = False)])
print()

result.drop_duplicates(inplace= True)

print(result)
print()
# 

customers_api = customers_api.rename(
    columns={
        'id' : 'customer_id',
        'customer_name' : 'name'
    }
)

result = pd.concat(
    [customers,customers_api],
    ignore_index= True 
)

result.drop_duplicates(inplace=True)

result = pd.merge(
    result,
    orders,
    on= 'customer_id'
)

print(result)