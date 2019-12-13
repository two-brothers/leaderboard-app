package com.twobrothers.leaderboard.scores.add

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.google.firebase.firestore.DocumentReference
import com.google.firebase.firestore.FirebaseFirestore
import com.google.firebase.firestore.SetOptions
import com.twobrothers.leaderboard.core.responces.FirebasePlayer
import com.twobrothers.leaderboard.players.models.Player
import java.util.*
import kotlin.collections.HashMap

class AddScoreViewModel(
    private val gameId: String
) {

    val score = MutableLiveData<String>()
    val player = MutableLiveData<Int>()

    private val _players = MutableLiveData<List<Player>>()
    val players: LiveData<List<Player>> = _players

    init {
        val db = FirebaseFirestore.getInstance()
        db.collection("players").get().addOnSuccessListener {
            _players.value = it.documents.mapNotNull {
                it.toObject(FirebasePlayer::class.java)?.toPlayer(it.id)
            }
        }
    }

    fun onSaveScore() {
        val db = FirebaseFirestore.getInstance()
        val ref = db.collection("sample").document("sampledoc")

        println("clicked update")

        val record = Lead(
            hashMapOf(
                Pair(
                    UUID.randomUUID().toString(),
                    TestScore("nitin", (Math.random() * 100).toInt())
                )
            )
        )

        ref.set(record, SetOptions.merge())

        /* ref.update("leaders", record, SetOptions.merge()).addOnSuccessListener {
            println("on update success")
        }*/

        // val score = Score()
        /* FirebaseFirestore
            .getInstance()
            .collection("games")
            .document(gameId)
            .set(score)*/
    }
}

data class Lead(
    val leaders: HashMap<String, TestScore>
)

data class TestScore(
    val name: String,
    val score: Int
)

data class Score(
    val date: Date, // FieldValue.serverTimestamp()
    val player: DocumentReference,
    val score: Int
)