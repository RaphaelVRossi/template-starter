package br.com.eng.template.user.controller;

import br.com.eng.template.user.model.User;
import br.com.eng.template.user.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/user")
public class UserController {

    private UserRepository service;
    private PasswordEncoder passwordEncoder;

    @Autowired
    public UserController(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.service = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @CrossOrigin
    @PostMapping()
    public ResponseEntity insert(@RequestBody User model) {
        if (model.getPassword() != null)
            model.setPassword(passwordEncoder.encode(model.getPassword()));
        return ResponseEntity.ok(service.save(model));
    }

    @CrossOrigin
    @GetMapping()
    public Iterable<User> findAll() {
        return service.findAll();
    }

    @CrossOrigin
    @GetMapping("/{id}")
    public User findById(@PathVariable("id") Integer id) {
        return service.findOne(id);
    }

    @CrossOrigin
    @PutMapping()
    public ResponseEntity update(@RequestBody User model) {
        return ResponseEntity.ok(service.save(model));
    }

    @CrossOrigin
    @DeleteMapping()
    public ResponseEntity delete(@RequestBody User model) {
        service.delete(model);
        return ResponseEntity.ok().build();
    }

    @CrossOrigin
    @DeleteMapping("/{id}")
    public ResponseEntity deleteById(@PathVariable("id") Integer id) {
        service.delete(id);
        return ResponseEntity.ok().build();
    }
}