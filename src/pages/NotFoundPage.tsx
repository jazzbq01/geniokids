import { Link } from 'react-router-dom';
import './NotFoundPage.css';

export function NotFoundPage() {
  return (
    <section className="notfound-page">
      <div>
        <h1>404</h1>
        <p>Esta ruta se fue al recreo.</p>
        <Link className="primary-button" to="/students">Volver a GenioKids</Link>
      </div>
    </section>
  );
}
