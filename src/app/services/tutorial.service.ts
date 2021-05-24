import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';

const baseUrl = 'http://localhost:4201/api/welcome';

@Injectable({
  providedIn: 'root'
})
export class TutorialService {

  constructor(private http: HttpClient) { }

  getAll() {
    return this.http.get(baseUrl);
  }
}
