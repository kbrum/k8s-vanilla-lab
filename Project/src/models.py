from pydantic import BaseModel


class Product(BaseModel):
    id: int
    name: str
    price: float


class Order(BaseModel):
    id: int
    product_id: int
    quantity: int
    total: float


class OrderCreate(BaseModel):
    product_id: int
    quantity: int
