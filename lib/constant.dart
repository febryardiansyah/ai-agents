const APIKEY = String.fromEnvironment('GEMINI_API_KEY');
const GEMINI_ICON = 'assets/gemini-icon.png';

enum BlocStatus { initial, loading, loaded, error }
