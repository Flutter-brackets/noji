abstract final class DomCleanerCss {
  static const String css = '''
:root {
  --announcement-height: 0px !important;
}
.announcement-bar,
.announcement-bar.marquee-mode,
[class*="announcement-bar"] {
  display: none !important;
  height: 0 !important;
  min-height: 0 !important;
  max-height: 0 !important;
  margin: 0 !important;
  padding: 0 !important;
  opacity: 0 !important;
  visibility: hidden !important;
  pointer-events: none !important;
  overflow: hidden !important;
}
html.noji-app,
html.noji-app body,
html.noji-app * {
  -webkit-tap-highlight-color: transparent !important;
}
html.noji-app,
html.noji-app body {
  -webkit-touch-callout: none !important;
  user-select: none !important;
  -webkit-user-select: none !important;
}
html.noji-app input,
html.noji-app textarea,
html.noji-app [contenteditable="true"] {
  user-select: text !important;
  -webkit-user-select: text !important;
}
''';
}
