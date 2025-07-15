// Import payment method images
import creditCardImg from "../../assets/images/payment-methods/credit_card.png";
import touchNGoImg from "../../assets/images/payment-methods/Touch_'n_Go_logo.svg";
import shopeePayImg from "../../assets/images/payment-methods/shopeepay4268.jpg";
import grabPayImg from "../../assets/images/payment-methods/GrabPay_Final_Logo_RGB_green_horizontal-01.png";

const paymentMethods = [
  {
    id: "creditCard",
    value: "Credit Card",
    imageSrc: creditCardImg,
    altText: "Credit Card",
    labelText: "Credit Card",
  },
  {
    id: "touchNGo",
    value: "Touch 'n Go",
    imageSrc: touchNGoImg,
    altText: "Touch 'n Go",
    labelText: "Touch 'n Go",
  },
  {
    id: "shopeePay",
    value: "ShopeePay",
    imageSrc: shopeePayImg,
    altText: "ShopeePay",
    labelText: "ShopeePay",
  },
  {
    id: "grabPay",
    value: "GrabPay",
    imageSrc: grabPayImg,
    altText: "GrabPay",
    labelText: "GrabPay",
  },
];

export default paymentMethods;