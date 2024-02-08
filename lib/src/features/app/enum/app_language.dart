enum AppLanguage implements Comparable<AppLanguage> {
  kk('Қазақша', '🇰🇿', 'kk'),
  en('English', 'En', 'en'),
  ru('Русский', '🇷🇺', 'ru');

  const AppLanguage(this.title, this.flag, this.localeCode);

  final String title;
  final String flag;
  final String localeCode;

  R when<R>({
    required R Function() kk,
    required R Function() ru,
    required R Function() en,
  }) {
    switch (this) {
      case AppLanguage.kk:
        return kk();
      case AppLanguage.ru:
        return ru();
      case AppLanguage.en:
        return en();
    }
  }

  static AppLanguage fromString(String source) =>
      AppLanguage.values.byName(source);

  @override
  int compareTo(AppLanguage other) => index.compareTo(other.index);
}
