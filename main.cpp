#include <raylib.h>

int main() {
    InitWindow(1280, 720, "Reborn From The Ashes");

    while (!WindowShouldClose()) {
        BeginDrawing();
            ClearBackground(RAYWHITE);
            DrawText("Hello World!!!", 50, 100, 30, BLACK);
        EndDrawing();
    }

    CloseWindow();

    return 0;
}

