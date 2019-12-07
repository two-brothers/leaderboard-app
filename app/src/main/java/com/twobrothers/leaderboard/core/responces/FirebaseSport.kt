package com.twobrothers.leaderboard.core.responces

import com.twobrothers.leaderboard.sports.models.Sport

data class FirebaseSport(
    val title: String = ""
) {
    fun toSportsModel(id: String): Sport {
        return Sport(
            id,
            title
        )
    }
}