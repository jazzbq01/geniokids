import { getAssetUrl } from './assets';

let currentAudio: HTMLAudioElement | null = null;

export function playAudio(path?: string | null) {
  if (!path) return;

  try {
    if (currentAudio) {
      currentAudio.pause();
      currentAudio.currentTime = 0;
    }

    currentAudio = new Audio(getAssetUrl(path));
    currentAudio.volume = 1;

    currentAudio.play().catch(() => {
      console.warn('El navegador bloqueó el audio hasta que el niño toque la pantalla.');
    });
  } catch (error) {
    console.warn('No se pudo reproducir el audio:', error);
  }
}

export function stopAudio() {
  if (!currentAudio) return;

  currentAudio.pause();
  currentAudio.currentTime = 0;
  currentAudio = null;
}