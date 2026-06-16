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

export default function VisualChoiceGame({ activity, question, onComplete }: Props) {
  const config = question?.gameConfig ?? question?.game_config ?? {};
  const activityConfig = activity?.gameConfig ?? activity?.game_config ?? {};

  const options = config.options ?? question?.options ?? [];
  const answer = String(config.answer ?? question?.correctAnswer ?? question?.correct_answer ?? '');
  const audio = config.audio ?? {};

  const instruction =
    activityConfig.instruction ??
    question?.prompt ??
    'Mira la imagen y toca la respuesta correcta.';

  const [message, setMessage] = useState('Mira la imagen y toca la respuesta correcta.');
  const [locked, setLocked] = useState(false);

  function handleListen() {
    playAudio(audio.instruction ?? question?.audioUrl ?? question?.audio_url);
  }

  function handleAnswer(value: any) {
    if (locked) return;

    const selected = String(value);

    if (selected === answer) {
      setLocked(true);
      setMessage('¡Muy bien!');
      playAudio(audio.success);

      setTimeout(() => {
        playAudio(audio.complete);

        onComplete({
          score: 100,
          totalQuestions: 1,
          correctAnswers: 1,
          stars: 3
        });
      }, 1000);

      return;
    }

    setMessage('Mira otra vez e intenta de nuevo.');
    playAudio(audio.error);
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

      <div style={{ display: 'flex', justifyContent: 'center', margin: '20px 0' }}>
        <img
          src={getAssetUrl(config.image ?? question?.imageUrl ?? question?.image_url)}
          alt="Imagen principal"
          style={{ maxWidth: 280, width: '100%', objectFit: 'contain' }}
        />
      </div>

      <div className="answer-grid">
        {options.map((option: any) => (
          <button
            key={option.id}
            type="button"
            className="answer-button"
            onClick={() => handleAnswer(option.id)}
            disabled={locked}
          >
            {option.image && (
              <img
                src={getAssetUrl(option.image)}
                alt={option.label}
                style={{ width: 100, height: 100, objectFit: 'contain' }}
              />
            )}
            <strong>{option.label}</strong>
          </button>
        ))}
      </div>
    </article>
  );
}
