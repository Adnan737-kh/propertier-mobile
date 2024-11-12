# propertier_app_production


# nearby service
# top selling services


Real-Time Bidding and Orders
•	Create Bid from Customer Side:
API Location: Services API -> Bids -> Create from Customer Side
•	Connect to WebSocket from Vendor Side (to receive real-time bids):
API Location: Chat API and WebSockets -> Filtered Bids
•	Connect to Bid Socket from Customer Side:
API Location: Chat API and WebSockets -> Real-Time Bid Responses
•	Respond to Bid from Vendor Side with Amount:
API Location: Services API -> Bid Responses -> Create from Vendor Side
•	Accept Bid Response from Customer Side:
API Location: Services API -> Bid Responses -> Accept from Customer Side
•	Set Main Bid Status to Accepted and Add BidResponse Amount to Bid Amount:
API Location: Services API -> Bids -> Finalize from Customer Side
•	Create an Order for the Bid with Pending Status:
API Location: Services API -> Orders -> Create Pending Order from Bid
•	Keep Updating Vendor Live Location After Some Time:
API Location: Services API -> Vendor Live Location -> Update Vendor Location
•	Keep Tracking Vendor Location from Customer Side:
API Location: Services API -> Vendor Live Location -> Track Vendor Location


•	Cancel Order and Add Reason (when vendor is coming):
API Location: Services API -> Orders -> Cancel with Reason

•	Submit Order for Customer Review (from vendor side):
Submit image_urls, extra_price, and work_description
API Location: Services API -> Orders -> Submit Order for Customer Review

•	Review Final Submission (from customer side):
•	If rejected: Change submission status to rejected and navigate to live chat between customer and vendor.
API Location: Services API -> Orders -> Reject Submission from Customer Side
•	If accepted: Complete order
API Location: Services API -> Orders -> Accept Submission from Customer Side
•	Leave Reviews After Order Completion:
Both customer and vendor can leave reviews.
API Location: Services API -> Feedbacks -> Vendor to Customer, Services API -> Feedbacks -> Customer to Vendor