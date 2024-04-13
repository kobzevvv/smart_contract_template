contract SimpleSale {
    address payable public seller;
    address public buyer;
    uint public price;
    bool public sold;

    // Event declaration for purchase completion
    event ItemSold(address indexed buyer, uint price);

    // Constructor to initialize seller and price
    constructor(uint _price) {
        seller = payable(msg.sender);
        price = _price;
        sold = false;
    }

    // Function to buy item
    function buyItem() external payable {
        require(!sold, "Item already sold");
        require(msg.value >= price, "Insufficient payment");

        sold = true;
        buyer = msg.sender;

        // Transfer funds to seller
        seller.transfer(msg.value);
        
        // Emit an event for the sale
        emit ItemSold(buyer, price);
    }

    // Function to cancel the sale (only by seller)
    function cancelSale() external {
        require(msg.sender == seller, "Only the seller can cancel the sale");
        require(!sold, "Sale already completed");

        // Logic to cancel the sale
        sold = true; // Prevents further purchases

        // Emit an event or additional logic as needed
    }
}