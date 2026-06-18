import { Bar, BarChart, CartesianGrid, Cell, ResponsiveContainer, Tooltip, XAxis, YAxis } from 'recharts';

type ProgressChartItem = {
  subject: string;
  average: number;
  color?: string;
};

const COURSE_COLORS = [
  '#6c5ce7',
  '#00b894',
  '#0984e3',
  '#00cec9',
  '#a29bfe',
  '#e17055',
  '#fdcb6e',
  '#ff7675',
  '#2d3436'
];

function getCourseColor(item: ProgressChartItem, index: number) {
  return item.color || COURSE_COLORS[index % COURSE_COLORS.length];
}

export function ProgressChart({ data }: { data: ProgressChartItem[] }) {
  return (
    <div className="chart-card">
      <h3>Avance por curso</h3>
      <ResponsiveContainer width="100%" height={260}>
        <BarChart data={data}>
          <CartesianGrid strokeDasharray="3 3" />
          <XAxis dataKey="subject" tick={{ fontSize: 11 }} />
          <YAxis domain={[0, 100]} />
          <Tooltip formatter={(value: number | string) => [`${value}%`, 'Promedio']} />
          <Bar dataKey="average" radius={[10, 10, 0, 0]}>
            {data.map((item, index) => (
              <Cell key={`course-bar-${item.subject}-${index}`} fill={getCourseColor(item, index)} />
            ))}
          </Bar>
        </BarChart>
      </ResponsiveContainer>
    </div>
  );
}
