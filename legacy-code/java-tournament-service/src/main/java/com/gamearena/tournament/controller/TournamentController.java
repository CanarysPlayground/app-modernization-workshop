package com.gamearena.tournament.controller;

import com.gamearena.tournament.model.Tournament;
import com.gamearena.tournament.model.TournamentStatus;
import com.gamearena.tournament.service.TournamentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

/**
 * Legacy REST Controller - BLOCKING I/O
 * Needs migration to WebFlux with Mono/Flux
 */
@RestController
@RequestMapping("/api/tournaments")
public class TournamentController {

    @Autowired
    private TournamentService tournamentService;

    /**
     * Get all tournaments - BLOCKING call
     */
    @GetMapping
    public ResponseEntity<List<Tournament>> getAllTournaments() {
        List<Tournament> tournaments = tournamentService.findAll();
        return ResponseEntity.ok(tournaments);
    }

    /**
     * Get tournament by ID - BLOCKING call
     */
    @GetMapping("/{id}")
    public ResponseEntity<Tournament> getTournamentById(@PathVariable Long id) {
        try {
            Tournament tournament = tournamentService.findById(id);
            return ResponseEntity.ok(tournament);
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }

    /**
     * Create tournament - BLOCKING call
     */
    @PostMapping
    public ResponseEntity<Tournament> createTournament(@Valid @RequestBody Tournament tournament) {
        Tournament created = tournamentService.save(tournament);
        return ResponseEntity.status(HttpStatus.CREATED).body(created);
    }

    /**
     * Update tournament - BLOCKING call
     */
    @PutMapping("/{id}")
    public ResponseEntity<Tournament> updateTournament(
            @PathVariable Long id,
            @Valid @RequestBody Tournament tournamentDetails) {
        try {
            Tournament updated = tournamentService.update(id, tournamentDetails);
            return ResponseEntity.ok(updated);
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }

    /**
     * Delete tournament - BLOCKING call
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteTournament(@PathVariable Long id) {
        try {
            tournamentService.delete(id);
            return ResponseEntity.noContent().build();
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }

    /**
     * Get tournaments by status - BLOCKING call
     */
    @GetMapping("/status/{status}")
    public ResponseEntity<List<Tournament>> getTournamentsByStatus(@PathVariable TournamentStatus status) {
        List<Tournament> tournaments = tournamentService.findByStatus(status);
        return ResponseEntity.ok(tournaments);
    }

    /**
     * Get tournaments by game - BLOCKING call
     */
    @GetMapping("/game/{game}")
    public ResponseEntity<List<Tournament>> getTournamentsByGame(@PathVariable String game) {
        List<Tournament> tournaments = tournamentService.findByGame(game);
        return ResponseEntity.ok(tournaments);
    }
}
