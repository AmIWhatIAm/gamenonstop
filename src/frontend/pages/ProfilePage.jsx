import { useState, useEffect, useContext } from "react";
import { FaUserCircle } from "react-icons/fa";
import UserContext from "./LoginContext";
import axios from "axios";
import { useNavigate } from "react-router-dom";
import "../css/profile-page.css";

//Mock user
const ProfilePage = () => {
  const navigate = useNavigate();
  const { user } = useContext(UserContext);
  const [purchases, setPurchases] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  // Mock data for testing
  useEffect(() => {
    const fetchPurchases = async () => {
      if (!user || !user.id) {
        setLoading(false);
        return;
      }

      try {
        const response = await axios.post(
          "http://localhost/gamenonstop/src/backend/php/get_user_games.php",
          { user_id: user.id },
          {
            headers: {
              "Content-Type": "application/json",
            },
          }
        );

        console.log("Purchase response:", response.data);

        if (response.data.success) {
          setPurchases(response.data.game_list);
        } else {
          console.error("Error fetching purchases:", response.data.error);
          setPurchases([]);
        }
      } catch (error) {
        console.error("Error fetching purchases:", error);
        setPurchases([]);
      } finally {
        setLoading(false);
      }
    };

    fetchPurchases();
  }, [user]);

  if (loading) return <p>Loading...</p>;
  if (error) return <p>{error}</p>;

  return (
    <div>
      <div className="profile-page">
        <header className="profile-header">
          {user ? (
            user.picture ? (
              <img
                src={user.picture}
                alt={user.name ? user.name : user.username}
              />
            ) : (
              <FaUserCircle className="profile-placeholder" />
            )
          ) : (
            <FaUserCircle className="profile-placeholder" />
          )}
          <div className="profile-info">
            <h1>{user ? (user.name ? user.name : user.username) : "Guest"}</h1>
            <p>{user ? user.email : "No email"}</p>
          </div>
        </header>
        <section className="profile-games">
          <h2>Purchased Games</h2>
          {purchases.length === 0 ? (
            <p>No games purchased</p>
          ) : (
            <ul className="games-list">
              {purchases.map((game) => (
                <li key={game.game_id} className="game-item">
                  <img
                    src={game.img_src}
                    alt={game.title}
                    className="game-img"
                  />
                  <div className="game-details">
                    <h3>{game.title}</h3>
                  </div>
                </li>
              ))}
            </ul>
          )}
        </section>
      </div>
    </div>
  );
};

export default ProfilePage;
