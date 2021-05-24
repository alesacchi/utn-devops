import { Component, Injectable } from '@angular/core';
import { TutorialService } from 'src/app/services/tutorial.service';
import { WelcomeModel } from './services/Welcome.model';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.sass']
})

@Injectable({
  providedIn: 'root'
})

export class AppComponent {

  constructor(private tutorialService: TutorialService) { }
  title = 'utn-devops-app';
  query = "";
  welcomes: WelcomeModel[] = [];

  public Prueba() {
    this.query = "";
    this.tutorialService.getAll()
      .subscribe(
        data => {
          let blob = (data as WelcomeModel[] );
          blob.forEach(wel => {
            this.query += wel.description + '\n';
          });
          console.log(data);
        },
        error => {
          this.query = error.error.text;
        });
  }
}
