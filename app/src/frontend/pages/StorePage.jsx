import axios from "axios";
import { useEffect, useState, useContext } from "react";
import { Link } from "react-router-dom";
import UserContext from "./LoginContext";

function Store() {
  const { user, loginUser } = useContext(UserContext);
  const [games, setGames] = useState([]); // Initialize as an empty array
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const loadGames = async () => {
      try {
        const response = await axios.get(
          "http://localhost/y2s1-web-app/app/src/backend/php/get_game.php",
        );
        setGames(response.data); // Set the fetched data to games state
      } catch (error) {
        setError(error);
      } finally {
        setLoading(false);
      }
    };
    loadGames();
  }, []);

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error loading games: {error.message}</p>;

  return (
    <div>
      <h1>Store</h1>
      <div className="my-0 mx-auto">
        <ul className="product-list grid grid-cols-1 sm:grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {games.map((game) => (
            <li key={game.game_id}>
              <ProductCard
                slug={game.game_id}
                title={game.title}
                imgSrc={game.img_src}
                price={game.price}
              />
            </li>
          ))}
        </ul>
      </div>
    </div>
  );
}

function ProductCard({ slug, title, imgSrc, price }) {
  return (
    <div className="m-3 h-auto max-w-xs rounded-xl bg-gray-200 p-3 shadow-sm hover:scale-105 hover:bg-red-100">
      <Link to={`/store/${slug}`} className="rounded-md">
        <img
          className="h-35 rounded-md object-scale-down"
          src={imgSrc}
          alt={title}
        />
      </Link>
      <Link to={`/store/${slug}`}>
        <p className="truncate py-2 text-lg font-bold">{title}</p>
      </Link>
      <p>{parseFloat(price) === 0.0 ? "FREE" : `RM ${price}`}</p>
    </div>
  );
}

export default Store;
