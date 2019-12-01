package com.twobrothers.leaderboard.sports

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.google.firebase.firestore.FirebaseFirestore
import com.twobrothers.leaderboard.sports.models.FirebaseSport
import com.twobrothers.leaderboard.sports.models.Sport

class SportsViewModel {

    private val _sports = MutableLiveData<List<Sport>>()
    val sports: LiveData<List<Sport>> = _sports

    init {
        val db = FirebaseFirestore.getInstance()
        db.collection("sports").get().addOnSuccessListener {
            _sports.value = it.documents.mapNotNull {
                it.toObject(FirebaseSport::class.java)?.toSportsModel()
            }
        }
    }

    fun onSportClick(title: String) {
        // TODO: Implement on sport click
    }
}