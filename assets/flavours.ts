export interface Flavour {
  id: string;
  name: string;
  nameJa: string;
  description: string;
  descriptionJa: string;
  price: number;
  color: string;
  tags: string[];
}

export const flavours: Flavour[] = [
  {
    id: '1',
    name: 'Chocolat Supernova',
    nameJa: 'スーパーノヴァ・チョコレート',
    description: 'Explosion de chocolat noir belge avec des éclats de cacao torréfié.',
    descriptionJa: '焙煎カカオのかけらとベルギー産ダークチョコレートの爆発。',
    price: 4.50,
    color: '#5D3A1A',
    tags: ['organic'],
  },
  {
    id: '2',
    name: 'Fruit de la Passion Orion',
    nameJa: 'オリオン・パッションフルーツ',
    description: 'Fruit de la passion exotique avec une touche de vanille stellaire.',
    descriptionJa: 'エキゾチックなパッションフルーツと星のバニラのタッチ。',
    price: 5.00,
    color: '#FF6B35',
    tags: ['vegan', 'glutenFree'],
  },
  {
    id: '3',
    name: 'Café Nébuleuse',
    nameJa: 'ネビュラ・コーヒー',
    description: 'Espresso italien intense avec des notes de caramel cosmique.',
    descriptionJa: 'コズミックキャラメルノート入りイタリアン・エスプレッソ。',
    price: 4.50,
    color: '#6F4E37',
    tags: ['organic'],
  },
  {
    id: '4',
    name: 'Pistache Andromède',
    nameJa: 'アンドロメダ・ピスタチオ',
    description: 'Pistache de Sicile premium avec un voile de miel astral.',
    descriptionJa: 'アストラルハニーのベールを纏ったシチリア産プレミアムピスタチオ。',
    price: 5.50,
    color: '#93C572',
    tags: ['containsPeanuts', 'organic'],
  },
  {
    id: '5',
    name: 'Citron Solaire',
    nameJa: 'ポラリス・レモン',
    description: 'Citron de Menton acidulé avec du zeste cristallisé.',
    descriptionJa: 'クリスタル皮付きマントン産の爽やかなレモン。',
    price: 4.00,
    color: '#FFF44F',
    tags: ['vegan', 'lactoseFree', 'glutenFree'],
  },
  {
    id: '6',
    name: 'Fraise Voie Lactée',
    nameJa: 'ミルキーウェイ・ストロベリー',
    description: 'Fraises des bois avec une crème onctueuse de la galaxie.',
    descriptionJa: 'ギャラクシークリーム入りワイルドストロベリー。',
    price: 4.50,
    color: '#FF6B6B',
    tags: ['glutenFree'],
  },
  {
    id: '7',
    name: 'Tiramisu Saturne',
    nameJa: 'サターン・ティラミス',
    description: 'Mascarpone céleste avec café et cacao en anneaux.',
    descriptionJa: '天のマスカルポーネとコーヒーとココアのリング。',
    price: 5.50,
    color: '#D4A574',
    tags: ['containsAlcohol'],
  },
  {
    id: '8',
    name: 'Matcha Aurore Boréale',
    nameJa: 'オーロラ・抹茶',
    description: 'Thé matcha de Kyoto avec des reflets de lumière nordique.',
    descriptionJa: '北の光の反射を持つ京都産抹茶。',
    price: 5.00,
    color: '#7AB77A',
    tags: ['vegan', 'organic'],
  },
  {
    id: '9',
    name: 'Mangue Pulsar',
    nameJa: 'パルサー・マンゴー',
    description: 'Mangue Alfonso pulsante avec une explosion de passion.',
    descriptionJa: 'パッションの爆発を伴う脈打つアルフォンソマンゴー。',
    price: 4.50,
    color: '#FFB347',
    tags: ['vegan', 'lactoseFree', 'glutenFree'],
  },
  {
    id: '10',
    name: 'Fruit du Dragon Cosmos',
    nameJa: 'コスモス・ドラゴンフルーツ',
    description: 'Pitaya rose vibrante avec des pépites de kiwi galactique.',
    descriptionJa: '銀河キウイのかけら入り鮮やかなピンクピタヤ。',
    price: 5.50,
    color: '#FF1493',
    tags: ['vegan', 'glutenFree'],
  },
];
