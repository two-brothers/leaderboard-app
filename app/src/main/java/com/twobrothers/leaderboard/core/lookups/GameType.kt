package com.twobrothers.leaderboard.core.lookups

enum class GameType(
    val id: Int
) {
    POSITION(0),
    HIGH_SCORE(1),
    LOW_SCORE(2);

    companion object {
        fun getById(id: Int) = values().firstOrNull { it.id == id }
    }
}