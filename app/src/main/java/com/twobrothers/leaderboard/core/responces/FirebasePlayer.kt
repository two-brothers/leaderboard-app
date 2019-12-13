package com.twobrothers.leaderboard.core.responces

import com.twobrothers.leaderboard.players.models.Player

data class FirebasePlayer(
    val name: String = ""
) {
    fun toPlayer(id: String): Player {
        return Player(id, name)
    }
}