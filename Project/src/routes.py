from fastapi import APIRouter, HTTPException

from src.models import Order, OrderCreate, Product


router = APIRouter()

products: list[Product] = [
    Product(id=1, name="Notebook", price=3500.0),
    Product(id=2, name="Keyboard", price=250.0),
    Product(id=3, name="Mouse", price=120.0),
]

orders: list[Order] = []


@router.get("/health")
def health():
    return {"status": "ok"}


@router.get("/products", response_model=list[Product])
def list_products():
    return products


@router.get("/orders", response_model=list[Order])
def list_orders():
    return orders


@router.post("/orders", response_model=Order)
def create_order(order_create: OrderCreate):
    product = next(
        (product for product in products if product.id == order_create.product_id),
        None,
    )

    if product is None:
        raise HTTPException(status_code=404, detail="Product not found")

    order = Order(
        id=len(orders) + 1,
        product_id=order_create.product_id,
        quantity=order_create.quantity,
        total=product.price * order_create.quantity,
    )
    orders.append(order)

    return order
