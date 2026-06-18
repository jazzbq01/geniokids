import ShapeSortGame from './ShapeSortGame';
import ColorSortGame from './ColorSortGame';
import TapCountGame from './TapCountGame';
import MemoryGame from './MemoryGame';
import VisualChoiceGame from './VisualChoiceGame';

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

export default function GameRenderer({ activity, question, onComplete }: Props) {
  const gameType = activity?.game_type || question?.game_config?.game;

  if (gameType === 'shape_sort') {
    return <ShapeSortGame activity={activity} question={question} onComplete={onComplete} />;
  }

  if (gameType === 'color_sort') {
    return <ColorSortGame activity={activity} question={question} onComplete={onComplete} />;
  }

  if (gameType === 'tap_count') {
    return <TapCountGame activity={activity} question={question} onComplete={onComplete} />;
  }

  if (gameType === 'memory_game') {
    return <MemoryGame activity={activity} question={question} onComplete={onComplete} />;
  }

  if (gameType === 'visual_choice') {
    return <VisualChoiceGame activity={activity} question={question} onComplete={onComplete} />;
  }

  return (
    <div className="p-6 text-center">
      <h2 className="text-2xl font-bold text-slate-800">Juego no disponible</h2>
      <p className="mt-2 text-slate-600">Este tipo de juego todavía no tiene componente visual.</p>
    </div>
  );
}