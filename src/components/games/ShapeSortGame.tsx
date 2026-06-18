import { useState } from 'react';
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

export default function ShapeSortGame({ activity, question, onComplete }: Props) {
  const config = question?.gameConfig ?? question?.game_config ?? {};
  const activityConfig = activity?.gameConfig ?? activity?.game_config ?? {};

  const items = config.items ?? [];
  const targets = config.targets ?? [];
  const audio = config.audio ?? {};

  const instruction =
    activityConfig.instruction ??
    question?.prompt ??
    'Arrastra cada figura a la caja correcta.';

  const [selectedItem, setSelectedItem] = useState<any | null>(null);
  const [placed, setPlaced] = useState<Record<string, string>>({});
  const [message, setMessage] = useState('Toca una figura y luego toca su caja.');

  function handleListen() {
    playAudio(audio.instruction ?? question?.audioUrl ?? question?.audio_url);
  }

  function handleSelectItem(item: any) {
    setSelectedItem(item);
    setMessage(`Ahora toca la caja de: ${item.label}`);
    playAudio(audio.select);
  }

  function handleTargetClick(target: any) {
    if (!selectedItem) {
      setMessage('Primero toca una figura.');
      playAudio(audio.select ?? audio.listen);
      return;
    }

    if (target.accepts !== selectedItem.type) {
      setMessage('Casi. Esa no es su caja. Intenta otra vez.');
      playAudio(audio.error);
      return;
    }

    const nextPlaced = {
      ...placed,
      [target.id]: selectedItem.id
    };

    setPlaced(nextPlaced);
    setSelectedItem(null);
    setMessage('¡Muy bien!');
    playAudio(audio.success);

    if (Object.keys(nextPlaced).length >= targets.length) {
      setTimeout(() => {
        playAudio(audio.complete);

        onComplete({
          score: 100,
          totalQuestions: targets.length,
          correctAnswers: targets.length,
          stars: 3
        });
      }, 1000);
    }
  }

  const placedItemIds = new Set(Object.values(placed));

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
        {items
          .filter((item: any) => !placedItemIds.has(item.id))
          .map((item: any) => (
            <button
              key={item.id}
              type="button"
              className={`answer-button ${
                selectedItem?.id === item.id ? 'answer-button--selected' : ''
              }`}
              onClick={() => handleSelectItem(item)}
            >
              <img
                src={getAssetUrl(item.image)}
                alt={item.label}
                style={{ width: 110, height: 110, objectFit: 'contain' }}
              />
              <strong>{item.label}</strong>
            </button>
          ))}
      </div>

      <div className="answer-grid" style={{ marginTop: 24 }}>
        {targets.map((target: any) => {
          const itemId = placed[target.id];

          return (
            <button
              key={target.id}
              type="button"
              className="answer-button"
              onClick={() => handleTargetClick(target)}
            >
              <img
                src={getAssetUrl(target.image)}
                alt={target.label}
                style={{ width: 120, height: 120, objectFit: 'contain' }}
              />
              <strong>{target.label}</strong>
              {itemId && <span>✅</span>}
            </button>
          );
        })}
      </div>
    </article>
  );
}