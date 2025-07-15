import '../../css/MainHeader.css';
import logo from '../../../assets/images/logo/GNS_Horizontal_Black.svg';
import { Link } from 'react-router-dom';

const MainHeader = () => (
  <header className="main-page-header">
    <img src={logo} alt="GameNonStop Logo" width="250" />
    <nav>
      <ul>
        <li>
          <Link to="/store">Shop</Link>
        </li>
        <li>
          <Link to="/#about-us">About Us</Link>
        </li>
        <li>
          <Link to="/faq">FAQ</Link>
        </li>
        <li>
          <Link to="/login" className="active">
            Login <i className="fa-solid fa-user"></i>
          </Link>
        </li>
      </ul>
    </nav>
  </header>
);

export default MainHeader;