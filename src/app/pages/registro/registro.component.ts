import { Component, OnInit } from '@angular/core';
import { Usuario } from 'src/app/core/model/Usuario';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { UsuarioDao } from 'src/app/core/dao/UsuarioDao';
import { Router } from '@angular/router';

@Component({
  selector: 'app-registro',
  templateUrl: './registro.component.html',
  styleUrls: ['./registro.component.scss'],
  standalone: false
})
export class RegistroComponent implements OnInit {

  constructor(
    private formBuilder: FormBuilder,
    private usuarioDao: UsuarioDao,
    private router: Router
  ) { 
    this.loadForm();
  }

  ngOnInit(): void {
    this.usuario = new Usuario();
  }

  loadForm(){
    this.registroUsuario = this.formBuilder.group({
      nombre: ["", Validators.required],
      apellido: ["", Validators.required],
      email: ["", Validators.required],
      password: ["", Validators.required],
      validar_password: ["", Validators.required],
      agreedToTerms: [null, Validators.requiredTrue]
    });
  }

  registroUsuario!: FormGroup;
  usuario: Usuario = new Usuario();

  get form() {
    return this.registroUsuario?.controls;
  }


  registrar() {
    this.usuarioDao.guardarUsuario(this.usuario).subscribe(
      result => {
        alert('Usuario Registrado con Éxito');
        this.router.navigate(['/login']);
      }
    );
  }

}
