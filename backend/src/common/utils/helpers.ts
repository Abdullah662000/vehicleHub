export function photoKeyForModel(model: string): string {
  const m = model.toLowerCase();
  if (m.includes('civic')) return 'civic';
  if (m.includes('sportage')) return 'sportage';
  if (m.includes('hilux')) return 'hilux';
  if (m.includes('alto')) return 'alto';
  if (m.includes('city')) return 'city';
  if (m.includes('tucson')) return 'tucson';
  if (m.includes('mg')) return 'mg';
  if (m.includes('corolla')) return 'corolla';
  return 'corolla';
}

export function formatRelativeDate(date: Date, now = new Date()): string {
  const startOfDay = (d: Date) =>
    new Date(d.getFullYear(), d.getMonth(), d.getDate()).getTime();
  const diffDays = Math.round(
    (startOfDay(now) - startOfDay(date)) / (1000 * 60 * 60 * 24),
  );
  if (diffDays <= 0) return 'Today';
  if (diffDays === 1) return 'Yesterday';
  if (diffDays < 7) return `${diffDays} days ago`;
  return date.toLocaleDateString('en-GB', {
    day: '2-digit',
    month: 'short',
    year: 'numeric',
  });
}

export const CATEGORY_COLORS: Record<string, string> = {
  Fuel: '#1B4DFF',
  Service: '#10B981',
  Repairs: '#FF7A1A',
  'Toll Tax': '#94A3B8',
  'Car Wash': '#0EA5E9',
  Parking: '#8B5CF6',
  Other: '#94A3B8',
};
