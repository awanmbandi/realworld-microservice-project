Find **Protocol Buffers Descriptions** at the [`./protos` directory](/protos).

| Service                                              | Language      | Description                                                                                                                       |
| ---------------------------------------------------- | ------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| [frontend](/src/frontend)                           | Go            | Exposes an HTTP server to serve the website. Does not require signup/login and generates session IDs for all users automatically. |
| [cartservice](/src/cartservice)                     | C#            | Stores the items in the user's shopping cart in Redis and retrieves it.                                                           |
| [productcatalogservice](/src/productcatalogservice) | Go            | Provides the list of products from a JSON file and ability to search products and get individual products.                        |
| [currencyservice](/src/currencyservice)             | Node.js       | Converts one money amount to another currency. Uses real values fetched from European Central Bank. It's the highest QPS service. |
| [paymentservice](/src/paymentservice)               | Node.js       | Charges the given credit card info (mock) with the given amount and returns a transaction ID.                                     |
| [shippingservice](/src/shippingservice)             | Go            | Gives shipping cost estimates based on the shopping cart. Ships items to the given address (mock)                                 |
| [emailservice](/src/emailservice)                   | Python        | Sends users an order confirmation email (mock).                                                                                   |
| [checkoutservice](/src/checkoutservice)             | Go            | Retrieves user cart, prepares order and orchestrates the payment, shipping and the email notification.                            |
| [recommendationservice](/src/recommendationservice) | Python        | Recommends other products based on what's given in the cart.                                                                      |
| [adservice](/src/adservice)                         | Java          | Provides text ads based on given context words.                                                                                   |
| [loadgenerator](/src/loadgenerator)                 | Python/Locust | Continuously sends requests imitating realistic user shopping flows to the frontend.

This YAML file describes the configuration for deploying a set of microservices in a Kubernetes cluster. Let's break down how each microservice is connected:

1. **Email Service:**
   - Deployment Name: `emailservice`
   - Service Name: `emailservice`
   - Container Port: 8080
   - Exposed Port: 5000
   - Connects to: Unknown (service not mentioned in this YAML, might be in another file)

2. **Checkout Service:**
   - Deployment Name: `checkoutservice`
   - Service Name: `checkoutservice`
   - Container Port: 5050
   - Exposed Port: 5050
   - Connects to:
     - Product Catalog Service at `productcatalogservice:3550`
     - Shipping Service at `shippingservice:50051`
     - Payment Service at `paymentservice:50051`
     - Email Service at `emailservice:5000`
     - Currency Service at `currencyservice:7000`
     - Cart Service at `cartservice:7070`

3. **Recommendation Service:**
   - Deployment Name: `recommendationservice`
   - Service Name: `recommendationservice`
   - Container Port: 8080
   - Exposed Port: 8080
   - Connects to: Product Catalog Service at `productcatalogservice:3550`

4. **Frontend:**
   - Deployment Name: `frontend`
   - Service Name: `frontend`
   - Container Port: 8080
   - Exposed Ports:
     - 80 (NodePort)
     - 80 (LoadBalancer)
   - Connects to:
     - Product Catalog Service at `productcatalogservice:3550`
     - Currency Service at `currencyservice:7000`
     - Cart Service at `cartservice:7070`
     - Recommendation Service at `recommendationservice:8080`
     - Shipping Service at `shippingservice:50051`
     - Checkout Service at `checkoutservice:5050`
     - Ad Service at `adservice:9555`

5. **Payment Service:**
   - Deployment Name: `paymentservice`
   - Service Name: `paymentservice`
   - Container Port: 50051
   - Exposed Port: 50051
   - Connects to: None mentioned in this YAML, but likely used by other services

6. **Product Catalog Service:**
   - Deployment Name: `productcatalogservice`
   - Service Name: `productcatalogservice`
   - Container Port: 3550
   - Exposed Port: 3550
   - Connects to: None mentioned in this YAML, but likely used by other services

7. **Cart Service:**
   - Deployment Name: `cartservice`
   - Service Name: `cartservice`
   - Container Port: 7070
   - Exposed Port: 7070
   - Connects to: Redis at `redis-cart:6379`

8. **Load Generator:**
   - Deployment Name: `loadgenerator`
   - Connects to: Frontend at `frontend:80`

9. **Currency Service:**
   - Deployment Name: `currencyservice`
   - Service Name: `currencyservice`
   - Container Port: 7000
   - Exposed Port: 7000
   - Connects to: None mentioned in this YAML, but likely used by other services

10. **Shipping Service:**
    - Deployment Name: `shippingservice`
    - Service Name: `shippingservice`
    - Container Port: 50051
    - Exposed Port: 50051
    - Connects to: None mentioned in this YAML, but likely used by other services

11. **Redis for Cart Service:**
    - Deployment Name: `redis-cart`
    - Service Name: `redis-cart`
    - Container Port: 6379
    - Exposed Port: 6379
    - Connects to: None mentioned in this YAML, but used by Cart Service

12. **Ad Service:**
    - Deployment Name: `adservice`
    - Service Name: `adservice`
    - Container Port: 9555
    - Exposed Port: None
    - Connects to: None mentioned in this YAML, but likely used by other services

In summary, these microservices are interconnected through their respective services, and the Frontend service acts as the entry point for external communication. The connections between services are established using Kubernetes services and the specified ports. Additionally, some services, like Cart Service, use external services like Redis for data storage.



http://34.71.9.167:8080/multibranch-webhook-trigger/invoke?token=automation