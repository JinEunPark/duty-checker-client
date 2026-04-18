import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "오늘안부 · App Store Screenshots",
  description: "App Store screenshot generator for 오늘안부",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="ko" className="h-full antialiased">
      <body className="min-h-full flex flex-col" style={{ fontFamily: "'Pretendard', -apple-system, BlinkMacSystemFont, sans-serif" }}>{children}</body>
    </html>
  );
}
