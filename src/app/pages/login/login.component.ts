import { Component, inject } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { LogInDao } from 'src/app/core/api/dao/LogInDao';
import { AuthService } from 'src/app/core/services/auth.service';
import { TumbaService } from 'src/app/core/services/tumbaService';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent {

  username?: string = "";
  password?: string = "";
  registerForm!: FormGroup;
  submitted = false;
  loginError?: boolean;

  constructor(
    private formBuilder: FormBuilder,
    public loginDao: LogInDao,
    private router: Router,
    private autho: AuthService,
    private tumba: TumbaService
  ) {
    const session = inject(AuthService).getSession();
    if (session) {
      console.log("se envia al dashbord");
      this.router.navigate(['staff']);
    }
  }

  ngOnInit(): void {
    this.registerForm = this.formBuilder.group({
      username: ["", Validators.required],
      password: ["", Validators.required],
    })
    this.loginError = false;
  }

  get form() {
    return this.registerForm?.controls;
  }

  onSubmit() {
    this.submitted = true;
    if (this.registerForm?.invalid) {
      return;
    }
    //this.loginDao.login(this.tumba.encryptar(this.username!), this.tumba.encryptar(this.password!)).subscribe(
    this.loginDao.login(this.username!, this.password!).subscribe(
      result => {
        console.log("sucess : " + result.status);
        if (result.statusCode === 200) {
          localStorage.setItem('session', JSON.stringify(result.data));
          this.loginError = false;
          this.autho.setSession(result.data!);
          this.router.navigateByUrl('/learn-flow/dashboard');
          return;
        } else {
          this.loginError = true;
        }
      }
    );
  }

}
