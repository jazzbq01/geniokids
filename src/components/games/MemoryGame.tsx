import { useMemo, useState } from 'react';
import { getAssetUrl } from '../../utils/assets';
import { playAudio } from '../../utils/audio';

type GameResult = {
  score: number;
  totalQuestions: number;
  correctAnswers: number;
  stars: number;
};

type Props = {
  activity: any;
  question: any;
  onComplete: (result: GameResult) => void;
};

type MemoryCard = {
  uid: string;
  id: string;
  label: string;
  image: string;
};

function shuffleCards(cards: MemoryCard[]) {
  return cards
    .map((card) => ({ card, order: Math.random() }))
    .sort((a, b) => a.order - b.order)
    .map((item) => item.card);
}

export default function MemoryGame({ activity, question, onComplete }: Props) {
  const config = question?.gameConfig ?? question?.game_config ?? {};
  const activityConfig = activity?.gameConfig ?? activity?.game_config ?? {};

  const baseCards = config.cards ?? question?.pairs ?? [];
  const audio = config.audio ?? {};

  const instruction =
    activityConfig.instruction ??
    question?.prompt ??
    'Toca dos cartas y encuentra las parejas iguales.';

  const cards = useMemo(() => {
    const duplicated = baseCards.flatMap((card: any) => [
      {
        uid: `${card.id}-a`,
        id: card.id,
        label: card.label,
        image: card.image
      },
      {
        uid: `${card.id}-b`,
        id: card.id,
        label: card.label,
        image: card.image
      }
    ]);

    return shuffleCards(duplicated);
  }, [baseCards]);

  const [opened, setOpened] = useState<string[]>([]);
  const [matched, setMatched] = useState<string[]>([]);
  const [locked, setLocked] = useState(false);
  const [message, setMessage] = useState('Toca dos cartas y encuentra las parejas.');

  function handleListen() {
    playAudio(audio.instruction ?? question?.audioUrl ?? question?.audio_url);
  }

  function handleCardClick(card: MemoryCard) {
    if (locked) return;
    if (opened.includes(card.uid)) return;
    if (matched.includes(card.id)) return;

    playAudio(audio.listen);
    const nextOpened = [...opened, card.uid];
    setOpened(nextOpened);

    if (nextOpened.length === 2) {
      setLocked(true);

      const first = cards.find((item) => item.uid === nextOpened[0]);
      const second = cards.find((item) => item.uid === nextOpened[1]);

      if (first && second && first.id === second.id) {
        const nextMatched = [...matched, first.id];

        setTimeout(() => {
          setMatched(nextMatched);
          setOpened([]);
          setLocked(false);
          setMessage('¡Encontraste una pareja!');
          playAudio(audio.success);

          if (nextMatched.length >= baseCards.length) {
            setTimeout(() => {
              playAudio(audio.complete);

              onComplete({
                score: 100,
                totalQuestions: baseCards.length,
                correctAnswers: baseCards.length,
                stars: 3
              });
            }, 1000);
          }
        }, 600);
      } else {
        setTimeout(() => {
          setOpened([]);
          setLocked(false);
          setMessage('Sigue intentando.');
          playAudio(audio.error);
        }, 800);
      }
    }
  }

  return (
    <article className="question-card">
      <h2>{activityConfig.title ?? activity?.title}</h2>

      <p className="question-helper">💡 {instruction}</p>

      <button
        className="secondary-button"
        type="button"
        onClick={handleListen}
        style={{ marginBottom: 16 }}
      >
        🔊 Escuchar
      </button>

      <p className="question-helper">{message}</p>

      <div className="answer-grid">
        {cards.map((card) => {
          const isOpen = opened.includes(card.uid) || matched.includes(card.id);

          return (
            <button
              key={card.uid}
              type="button"
              className="answer-button"
              onClick={() => handleCardClick(card)}
              style={{ minHeight: 150 }}
            >
              {isOpen ? (
                <>
                  <img
                    src={getAssetUrl(card.image)}
                    alt={card.label}
                    style={{ width: 100, height: 100, objectFit: 'contain' }}
                  />
                  <strong>{card.label}</strong>
                </>
              ) : (
                <strong style={{ fontSize: 42 }}>❓</strong>
              )}
            </button>
          );
        })}
      </div>
    </article>
  );
}
