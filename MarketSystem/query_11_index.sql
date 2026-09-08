USE MarketSystem;
Go

--Speeds up joins or searches involving supplier-specific products.
CREATE NONCLUSTERED INDEX idx_Product_SupplierId ON Product(SupplierId);

--Optimizes category-based product listings and filters.
CREATE NONCLUSTERED INDEX idx_Product_CategoryId ON Product(CategoryId);

--Useful when retrieving all receipts by a customer.
CREATE NONCLUSTERED INDEX idx_Receipt_CustomerId ON Receipt(CustomerId);


--Improves performance when filtering receipts by employee.
CREATE NONCLUSTERED INDEX idx_Receipt_EmployeeId ON Receipt(EmployeeId);

--Helps when showing cart(s) associated with a customer.
CREATE NONCLUSTERED INDEX idx_Cart_CustomerId ON Cart(CustomerId);

--Accelerates finding all cart entries for a product
CREATE NONCLUSTERED INDEX idx_CartItem_ProductId ON CartItem(ProductId);

--Boosts queries linking receipts to their shipping status.
CREATE NONCLUSTERED INDEX idx_ShippingDetail_ReceiptId ON ShippingDetail(ReceiptId);

--Makes lookups of account by customer ID faster.
CREATE NONCLUSTERED INDEX idx_Account_CustomerId ON Account(CustomerId);