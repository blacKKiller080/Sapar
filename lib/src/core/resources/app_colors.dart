part of 'resources.dart';

mixin AppColors {
  static const Color kMainGreen = Color(0xff04C300);
  static const Color kSecondaryGray = Color(0xFFDCDCDC);
  static const Color kGlobalBackground = Color(0xffF7F7F7);
  static const Color kTextTertiary = Color(0xff566681);
  static const Color kTextSecondary = Color(0xff99A3B3);
  static const Color kBlue = Color(0xFF0085FF);
  static const Color kElementsSecondary = Color(0xff57667F);
  static const Color kElementsTertiary = Color(0xff9AA3B2);
  static const Color kBrandSecondary = Color(0xffEAF6EF);
  static const Color kTextBrandPrimary = Color(0xff2AA65C);
  static const Color kSurfaceSecondary = Color(0xffF1F2F6);
  static const Color kStatusSuccess = Color(0xff11D392);
  static const Color kSurfaceTertiary = Color(0xffE0E6EF);
  static const Color kElementsSurface = Color(0xff081221);

  static const Color kWhite = Colors.white;
  static const Color kBlack = Color(0xFF000000);
  static const Color kNeutralBorder = Color(0xffE5E5E5);
  static const Color kFoundationGrey = Color(0xff484848);
  static const Color kFoundationGreyLight = Color(0xffF6F6F6);
  static const Color kGreen = Color(0xff078D60);
  static const Color kFoundationBorderColor = Color(0xff919191);
  static const Color kYellow = Color(0xffFADF91);
  static const Color kGrey = Color(0xffE6E6E6);
  static const Color kGreyFillColor = Color(0xFFF5F5F5);
  static const Color kGreyNeutral = Color(0xff6F6A6A);
  static const Color kGrey6 = Color(0xff8D8D8D);
  static const Color kGrey9 = Color(0xff101828);
  static const Color kGreyDivider = Color(0xffBDBCBC);
  static const Color kDarkGreen = Color(0xff1FAF38);
  static const Color kGreyBorder = Color(0xffB0B0B0);
  static const Color kFoundationGreyLightHover = Color(0xffD9D9D9);
  static const Color kFoundationWhiteDarker = Color(0xff595959);
  static const Color kFoundationNormal = Color(0xff919191);
  static const Color kNeutralBorderDivider = Color(0xffE1E1E1);
  static const Color kNeutralGray50 = Color(0xffF1F1F1);
  static const Color kNeturalPrimaryText = Color(0xff1F1F1F);
  static const Color kOrange = Color(0xffF2904F);
  static const Color kTextFieldColor = Color(0xffF7F8FA);
  static const Color kRed = Color(0xffFF3636);
  static const Color kQRcodeBorder = Color(0xffD9D9D9);

  ///
  // static const Color kDark = Color(0xff404D61);
  // static const Color kCaption = Color(0xff4E4B66);
  // static const Color searchBg = Color.fromRGBO(239, 240, 247, 1.0);
  // static const Color searchText = Color.fromRGBO(110, 113, 145, 1); //4E4B66
  // static const Color catBg = Color.fromRGBO(247, 247, 252, 1.0);
  // static const Color kGray50 = Color.fromRGBO(249, 250, 251, 1);
  // static const Color kGray100 = Color.fromRGBO(242, 244, 247, 1);
  // static const Color kGray200 = Color.fromRGBO(196, 200, 204, 1);
  // static const Color kGray300 = Color.fromRGBO(153, 162, 173, 1);
  // static const Color kGray400 = Color.fromRGBO(144, 148, 153, 1);
  // static const Color kGray500 = Color.fromRGBO(102, 112, 133, 1);
  // static const Color kGray600 = Color.fromRGBO(71, 84, 103, 1);
  // static const Color kGray700 = Color.fromRGBO(69, 70, 71, 1);
  // static const Color kGray750 = Color.fromRGBO(54, 55, 56, 1);
  // static const Color kGray800 = Color.fromRGBO(44, 45, 46, 1);
  // static const Color kGray900 = Color.fromRGBO(16, 24, 40, 1);
  // static const Color kGray1000 = Color.fromRGBO(10, 10, 10, 1);

  // static const Color kAlpha12 = Color.fromRGBO(0, 0, 0, 0.12);
  // static const Color kBlueAlpha = Color(0xffe5f1ff);
  // static const Color floatingActionButton = Color.fromRGBO(5, 163, 87, 1.0);
  // static const Color reviewStar = Color.fromRGBO(255, 195, 0, 1);
  // static const Color kReviewBg = Color(0xffF7F7FC);
}

final Map<int, Color> primaryColorMap = {
  50: const Color.fromRGBO(177, 249, 163, .1),
  200: const Color.fromRGBO(177, 249, 163, .3),
  300: const Color.fromRGBO(177, 249, 163, .4),
  400: const Color.fromRGBO(177, 249, 163, .5),
  100: const Color.fromRGBO(177, 249, 163, .2),
  500: const Color.fromRGBO(177, 249, 163, .6),
  600: const Color.fromRGBO(177, 249, 163, .7),
  700: const Color.fromRGBO(177, 249, 163, .8),
  800: const Color.fromRGBO(177, 249, 163, .9),
  900: const Color.fromRGBO(177, 249, 163, 1),
};


/*
В конструкторе Color первые два символа означают opacity, ниже приведены hex для всех возможных значений.

100% — FF
99% — FC
98% — FA
97% — F7
96% — F5
95% — F2
94% — F0
93% — ED
92% — EB
91% — E8
90% — E6
89% — E3
88% — E0
87% — DE
86% — DB
85% — D9
84% — D6
83% — D4
82% — D1
81% — CF
80% — CC
79% — C9
78% — C7
77% — C4
76% — C2
75% — BF
74% — BD
73% — BA
72% — B8
71% — B5
70% — B3
69% — B0
68% — AD
67% — AB
66% — A8
65% — A6
64% — A3
63% — A1
62% — 9E
61% — 9C
60% — 99
59% — 96
58% — 94
57% — 91
56% — 8F
55% — 8C
54% — 8A
53% — 87
52% — 85
51% — 82
50% — 80
49% — 7D
48% — 7A
47% — 78
46% — 75
45% — 73
44% — 70
43% — 6E
42% — 6B
41% — 69
40% — 66
39% — 63
38% — 61
37% — 5E
36% — 5C
35% — 59
34% — 57
33% — 54
32% — 52
31% — 4F
30% — 4D
29% — 4A
28% — 47
27% — 45
26% — 42
25% — 40
24% — 3D
23% — 3B
22% — 38
21% — 36
20% — 33
19% — 30
18% — 2E
17% — 2B
16% — 29
15% — 26
14% — 24
13% — 21
12% — 1F
11% — 1C
10% — 1A
9% — 17
8% — 14
7% — 12
6% — 0F
5% — 0D
4% — 0A
3% — 08
2% — 05
1% — 03
0% — 00
*/
