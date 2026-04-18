"use client";

import React, { useState, useEffect, useRef, useCallback } from "react";
import { toPng } from "html-to-image";

/* ─── Canvas / Export ─── */
const W = 1284;
const H = 2778;

const IPHONE_SIZES = [
  { label: '6.5" Portrait', w: 1284, h: 2778 },
  { label: '6.5" Portrait (alt)', w: 1242, h: 2688 },
] as const;

/* ─── Mockup metrics ─── */
const MK_W = 1022;
const MK_H = 2082;
const SC_L = (52 / MK_W) * 100;
const SC_T = (46 / MK_H) * 100;
const SC_W = (918 / MK_W) * 100;
const SC_H = (1990 / MK_H) * 100;
const SC_RX = (126 / 918) * 100;
const SC_RY = (126 / 1990) * 100;
const MK_RATIO = MK_W / MK_H;

/* ─── Theme ─── */
const THEME = {
  primary: "#3182F6",
  primaryLight: "#EBF3FF",
  primaryDark: "#1B64DA",
  bg: "#F2F4F6",
  surface: "#FFFFFF",
  textPrimary: "#191F28",
  textSecondary: "#6B7684",
};

/* ─── Image preload ─── */
const IMAGE_PATHS = [
  "/mockup.png",
  "/app-icon.png",
  "/screenshots/en/landing.png",
  "/screenshots/en/login.png",
  "/screenshots/en/user_home.png",
  "/screenshots/en/guardian_home.png",
  "/screenshots/en/user_guardian_management.png",
];

const imageCache: Record<string, string> = {};

async function preloadAllImages() {
  await Promise.all(
    IMAGE_PATHS.map(async (path) => {
      const resp = await fetch(path);
      const blob = await resp.blob();
      const dataUrl = await new Promise<string>((resolve) => {
        const reader = new FileReader();
        reader.onloadend = () => resolve(reader.result as string);
        reader.readAsDataURL(blob);
      });
      imageCache[path] = dataUrl;
    })
  );
}

function img(path: string): string {
  return imageCache[path] || path;
}

/* ─── Width formula ─── */
function phoneW(cW: number, cH: number, clamp = 0.84) {
  return Math.min(clamp, 0.72 * (cH / cW) * MK_RATIO);
}

/* ─── Phone component ─── */
function Phone({ src, alt, style }: { src: string; alt: string; style?: React.CSSProperties }) {
  return (
    <div style={{ position: "relative", aspectRatio: `${MK_W}/${MK_H}`, ...style }}>
      <img src={img("/mockup.png")} alt="" style={{ display: "block", width: "100%", height: "100%" }} draggable={false} />
      <div
        style={{
          position: "absolute", zIndex: 10, overflow: "hidden",
          left: `${SC_L}%`, top: `${SC_T}%`, width: `${SC_W}%`, height: `${SC_H}%`,
          borderRadius: `${SC_RX}% / ${SC_RY}%`,
        }}
      >
        <img src={src} alt={alt} style={{ display: "block", width: "100%", height: "100%", objectFit: "cover", objectPosition: "top" }} draggable={false} />
      </div>
    </div>
  );
}

/* ─── Caption ─── */
function Caption({ cW, label, headline, light = false }: {
  cW: number; label: string; headline: React.ReactNode; light?: boolean;
}) {
  return (
    <div style={{ textAlign: "center", padding: `0 ${cW * 0.06}px` }}>
      <div style={{
        fontSize: cW * 0.028, fontWeight: 600, letterSpacing: "0.08em",
        color: light ? "rgba(255,255,255,0.7)" : THEME.primary,
        marginBottom: cW * 0.015, textTransform: "uppercase",
      }}>
        {label}
      </div>
      <div style={{
        fontSize: cW * 0.082, fontWeight: 700, lineHeight: 1.05,
        color: light ? "#FFFFFF" : THEME.textPrimary,
      }}>
        {headline}
      </div>
    </div>
  );
}

/* ─── Blob decoration ─── */
function Blob({ color, size, top, left, opacity = 0.3 }: {
  color: string; size: number; top: string; left: string; opacity?: number;
}) {
  return (
    <div style={{
      position: "absolute", width: size, height: size, borderRadius: "50%",
      background: color, filter: `blur(${size * 0.4}px)`, opacity,
      top, left, pointerEvents: "none",
    }} />
  );
}

/* ─── Slides ─── */
type SlideProps = { cW: number; cH: number };
type SlideDef = { id: string; component: (p: SlideProps) => React.JSX.Element };

const slides: SlideDef[] = [
  // Slide 1: Hero
  {
    id: "hero",
    component: ({ cW, cH }) => {
      const fw = phoneW(cW, cH) * 100;
      return (
        <div style={{
          width: "100%", height: "100%", position: "relative", overflow: "hidden",
          background: "linear-gradient(180deg, #FFFFFF 0%, #EBF3FF 40%, #D4E6FF 100%)",
        }}>
          <Blob color="#3182F6" size={cW * 0.6} top="-10%" left="60%" opacity={0.12} />
          <Blob color="#6AADFF" size={cW * 0.4} top="20%" left="-15%" opacity={0.1} />
          <div style={{ position: "absolute", top: "5%", left: 0, right: 0, display: "flex", flexDirection: "column", alignItems: "center" }}>
            <img src={img("/app-icon.png")} alt="오늘안부" style={{
              width: cW * 0.14, height: cW * 0.14, borderRadius: cW * 0.03,
              boxShadow: "0 8px 32px rgba(49,130,246,0.25)",
              marginBottom: cW * 0.03,
            }} draggable={false} />
            <div style={{
              fontSize: cW * 0.038, fontWeight: 600, color: THEME.primary,
              letterSpacing: "0.05em", marginBottom: cW * 0.02,
            }}>
              오늘안부
            </div>
            <div style={{
              fontSize: cW * 0.078, fontWeight: 700, lineHeight: 1.1,
              color: THEME.textPrimary, textAlign: "center",
            }}>
              매일 한 번,<br />소중한 안부를<br />확인하세요
            </div>
          </div>
          <Phone
            src={img("/screenshots/en/user_home.png")}
            alt="User Home"
            style={{
              position: "absolute", bottom: 0,
              width: `${fw}%`, left: "50%",
              transform: "translateX(-50%) translateY(13%)",
            }}
          />
        </div>
      );
    },
  },

  // Slide 2: Check-in
  {
    id: "check-in",
    component: ({ cW, cH }) => {
      const fw = phoneW(cW, cH) * 100;
      return (
        <div style={{
          width: "100%", height: "100%", position: "relative", overflow: "hidden",
          background: "linear-gradient(180deg, #F8FAFC 0%, #EBF3FF 100%)",
        }}>
          <Blob color="#3182F6" size={cW * 0.5} top="60%" left="70%" opacity={0.1} />
          <div style={{ position: "absolute", top: "6%", left: 0, right: 0 }}>
            <Caption cW={cW} label="안부 확인" headline={<>하트 한 번이면<br />오늘의 안부 완료</>} />
          </div>
          <Phone
            src={img("/screenshots/en/user_home.png")}
            alt="Check-in"
            style={{
              position: "absolute", bottom: 0,
              width: `${fw}%`, left: "50%",
              transform: "translateX(-50%) translateY(10%)",
            }}
          />
        </div>
      );
    },
  },

  // Slide 3: Guardian Dashboard (dark contrast)
  {
    id: "guardian-dashboard",
    component: ({ cW, cH }) => {
      const fw = phoneW(cW, cH) * 100;
      return (
        <div style={{
          width: "100%", height: "100%", position: "relative", overflow: "hidden",
          background: "linear-gradient(180deg, #0F172A 0%, #1E293B 50%, #0F172A 100%)",
        }}>
          <Blob color="#3182F6" size={cW * 0.7} top="30%" left="-20%" opacity={0.15} />
          <Blob color="#6AADFF" size={cW * 0.5} top="-10%" left="60%" opacity={0.1} />
          <div style={{ position: "absolute", top: "6%", left: 0, right: 0 }}>
            <Caption cW={cW} label="보호자 화면" headline={<>소중한 분의 안부를<br />한눈에 확인</>} light />
          </div>
          <Phone
            src={img("/screenshots/en/guardian_home.png")}
            alt="Guardian Dashboard"
            style={{
              position: "absolute", bottom: 0,
              width: `${fw}%`, left: "50%",
              transform: "translateX(-50%) translateY(10%)",
            }}
          />
        </div>
      );
    },
  },

  // Slide 4: Simple Login
  {
    id: "simple-login",
    component: ({ cW, cH }) => {
      const fw = phoneW(cW, cH, 0.72) * 100;
      return (
        <div style={{
          width: "100%", height: "100%", position: "relative", overflow: "hidden",
          background: "linear-gradient(180deg, #FFFFFF 0%, #F0F6FF 100%)",
        }}>
          <Blob color="#3182F6" size={cW * 0.5} top="65%" left="60%" opacity={0.1} />
          <Blob color="#6AADFF" size={cW * 0.3} top="5%" left="-10%" opacity={0.08} />
          <div style={{ position: "absolute", top: "6%", left: 0, right: 0 }}>
            <Caption cW={cW} label="간편 로그인" headline={<>전화번호 하나로<br />바로 시작</>} />
          </div>
          <Phone
            src={img("/screenshots/en/login.png")}
            alt="Login"
            style={{
              position: "absolute", bottom: 0,
              width: `${fw}%`, right: "-4%",
              transform: "translateY(10%)",
            }}
          />
        </div>
      );
    },
  },

  // Slide 5: Connection Management
  {
    id: "connection-mgmt",
    component: ({ cW, cH }) => {
      const fw = phoneW(cW, cH, 0.72) * 100;
      return (
        <div style={{
          width: "100%", height: "100%", position: "relative", overflow: "hidden",
          background: "linear-gradient(160deg, #EBF3FF 0%, #FFFFFF 50%, #F0FAFF 100%)",
        }}>
          <Blob color="#3182F6" size={cW * 0.5} top="50%" left="-15%" opacity={0.1} />
          <div style={{ position: "absolute", top: "6%", left: 0, right: 0 }}>
            <Caption cW={cW} label="연결 관리" headline={<>보호자 등록도<br />간편하게</>} />
          </div>
          <Phone
            src={img("/screenshots/en/user_guardian_management.png")}
            alt="Connection Management"
            style={{
              position: "absolute", bottom: 0,
              width: `${fw}%`, left: "-4%",
              transform: "translateY(10%)",
            }}
          />
        </div>
      );
    },
  },

  // Slide 6: Easy Start (blue contrast)
  {
    id: "easy-start",
    component: ({ cW, cH }) => {
      const fw = phoneW(cW, cH) * 100;
      return (
        <div style={{
          width: "100%", height: "100%", position: "relative", overflow: "hidden",
          background: "linear-gradient(180deg, #1B64DA 0%, #3182F6 50%, #6AADFF 100%)",
        }}>
          <Blob color="#FFFFFF" size={cW * 0.6} top="-15%" left="50%" opacity={0.08} />
          <Blob color="#FFFFFF" size={cW * 0.4} top="70%" left="-10%" opacity={0.06} />
          <div style={{ position: "absolute", top: "6%", left: 0, right: 0 }}>
            <Caption cW={cW} label="시작하기" headline={<>역할을 고르면<br />바로 시작</>} light />
          </div>
          <Phone
            src={img("/screenshots/en/landing.png")}
            alt="Landing"
            style={{
              position: "absolute", bottom: 0,
              width: `${fw}%`, left: "50%",
              transform: "translateX(-50%) translateY(13%)",
            }}
          />
          <div style={{
            position: "absolute", bottom: "4%", left: 0, right: 0,
            textAlign: "center", fontSize: cW * 0.03, fontWeight: 500,
            color: "rgba(255,255,255,0.7)",
          }}>
            지금 시작해 보세요
          </div>
        </div>
      );
    },
  },
];

/* ─── Preview with scale ─── */
function ScreenshotPreview({ slide, cW, cH, exportRef }: {
  slide: SlideDef; cW: number; cH: number;
  exportRef: (el: HTMLDivElement | null) => void;
}) {
  const previewRef = useRef<HTMLDivElement>(null);
  const [scale, setScale] = useState(0.2);

  useEffect(() => {
    const el = previewRef.current;
    if (!el) return;
    const parent = el.parentElement;
    if (!parent) return;
    const ro = new ResizeObserver(([entry]) => {
      const pw = entry.contentRect.width;
      setScale(pw / cW);
    });
    ro.observe(parent);
    return () => ro.disconnect();
  }, [cW]);

  const Slide = slide.component;

  return (
    <>
      {/* Preview */}
      <div style={{ position: "relative", width: "100%", paddingBottom: `${(cH / cW) * 100}%`, overflow: "hidden", borderRadius: 12, background: "#e5e7eb" }}>
        <div ref={previewRef} style={{
          position: "absolute", top: 0, left: 0, width: cW, height: cH,
          transform: `scale(${scale})`, transformOrigin: "top left",
        }}>
          <Slide cW={cW} cH={cH} />
        </div>
      </div>
      <div style={{ textAlign: "center", marginTop: 6, fontSize: 12, fontWeight: 600, color: "#6b7280" }}>
        {slide.id}
      </div>
      {/* Export (offscreen) */}
      <div ref={exportRef} style={{
        position: "absolute", left: -9999, top: 0, width: cW, height: cH,
        overflow: "hidden",
      }}>
        <Slide cW={cW} cH={cH} />
      </div>
    </>
  );
}

/* ─── Main page ─── */
export default function ScreenshotsPage() {
  const [ready, setReady] = useState(false);
  const [sizeIdx, setSizeIdx] = useState(0);
  const [exporting, setExporting] = useState<string | null>(null);
  const exportRefs = useRef<(HTMLDivElement | null)[]>([]);

  useEffect(() => {
    preloadAllImages().then(() => setReady(true));
  }, []);

  const captureSlide = useCallback(async (el: HTMLElement, w: number, h: number) => {
    el.style.left = "0px";
    el.style.opacity = "1";
    el.style.zIndex = "-1";
    const opts = { width: w, height: h, pixelRatio: 1, cacheBust: true };
    await toPng(el, opts);
    const dataUrl = await toPng(el, opts);
    el.style.left = "-9999px";
    el.style.opacity = "";
    el.style.zIndex = "";
    return dataUrl;
  }, []);

  const exportAll = useCallback(async () => {
    const size = IPHONE_SIZES[sizeIdx];
    for (let i = 0; i < slides.length; i++) {
      setExporting(`${i + 1}/${slides.length}`);
      const el = exportRefs.current[i];
      if (!el) continue;
      const dataUrl = await captureSlide(el, size.w, size.h);
      const a = document.createElement("a");
      a.href = dataUrl;
      a.download = `${String(i + 1).padStart(2, "0")}-${slides[i].id}-ko-${size.w}x${size.h}.png`;
      a.click();
      await new Promise((r) => setTimeout(r, 300));
    }
    setExporting(null);
  }, [sizeIdx, captureSlide]);

  if (!ready) {
    return (
      <div style={{ display: "flex", alignItems: "center", justifyContent: "center", height: "100vh", fontSize: 18, color: "#6b7280" }}>
        Loading images...
      </div>
    );
  }

  return (
    <div style={{ minHeight: "100vh", background: "#f3f4f6", position: "relative", overflowX: "hidden" }}>
      {/* Toolbar */}
      <div style={{
        position: "sticky", top: 0, zIndex: 50, background: "white",
        borderBottom: "1px solid #e5e7eb", display: "flex", alignItems: "center",
      }}>
        <div style={{ flex: 1, display: "flex", alignItems: "center", gap: 10, padding: "10px 16px", overflowX: "auto", minWidth: 0 }}>
          <span style={{ fontWeight: 700, fontSize: 14, whiteSpace: "nowrap" }}>오늘안부 · Screenshots</span>
          <div style={{ display: "flex", gap: 4, background: "#f3f4f6", borderRadius: 8, padding: 4, flexShrink: 0 }}>
            <button style={{
              padding: "4px 14px", borderRadius: 6, border: "none", cursor: "pointer",
              fontSize: 12, fontWeight: 600, whiteSpace: "nowrap",
              background: "white", color: "#2563eb",
            }}>
              iPhone
            </button>
          </div>
          <select
            value={sizeIdx}
            onChange={(e) => setSizeIdx(Number(e.target.value))}
            style={{ fontSize: 12, border: "1px solid #e5e7eb", borderRadius: 6, padding: "4px 10px" }}
          >
            {IPHONE_SIZES.map((s, i) => (
              <option key={i} value={i}>{s.label} — {s.w}x{s.h}</option>
            ))}
          </select>
        </div>
        <div style={{ flexShrink: 0, padding: "10px 16px", borderLeft: "1px solid #e5e7eb" }}>
          <button
            onClick={exportAll}
            disabled={!!exporting}
            style={{
              padding: "7px 20px", background: exporting ? "#93c5fd" : "#2563eb",
              color: "white", border: "none", borderRadius: 8, fontSize: 12,
              fontWeight: 600, cursor: exporting ? "default" : "pointer", whiteSpace: "nowrap",
            }}
          >
            {exporting ? `Exporting... ${exporting}` : "Export All"}
          </button>
        </div>
      </div>

      {/* Grid */}
      <div style={{
        display: "grid", gridTemplateColumns: "repeat(auto-fill, minmax(260px, 1fr))",
        gap: 24, padding: 24, maxWidth: 1400, margin: "0 auto",
      }}>
        {slides.map((slide, i) => (
          <ScreenshotPreview
            key={slide.id}
            slide={slide}
            cW={W}
            cH={H}
            exportRef={(el) => { exportRefs.current[i] = el; }}
          />
        ))}
      </div>
    </div>
  );
}
