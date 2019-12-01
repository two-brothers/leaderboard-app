package com.twobrothers.leaderboard.sports

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.google.firebase.firestore.FirebaseFirestore
import com.twobrothers.leaderboard.sports.models.FirebaseSportsModel
import com.twobrothers.leaderboard.sports.models.SportsModel

class SportsViewModel {

    private val _sports = MutableLiveData<List<SportsModel>>()
    val sports: LiveData<List<SportsModel>> = _sports

    init {
        val db = FirebaseFirestore.getInstance()
        db.collection("sports").get().addOnSuccessListener {
            _sports.value = it.documents.mapNotNull {
                it.toObject(FirebaseSportsModel::class.java)?.toSportsModel()
            }
        }
    }

    fun onSportClick(title: String) {
        println("clicked on $title")
    }
}