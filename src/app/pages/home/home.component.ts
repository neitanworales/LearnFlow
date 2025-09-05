import { AfterViewInit, Component, ElementRef } from '@angular/core';
import { jarallax, jarallaxVideo } from 'jarallax';

@Component({
    selector: 'app-home',
    templateUrl: './home.component.html',
    styleUrls: ['./home.component.scss'],
    standalone: false
})
export class HomeComponent implements AfterViewInit {

    constructor(
        private elRef: ElementRef
    ) {

    }   

    ngAfterViewInit(): void {
        jarallax(document.querySelectorAll('.jarallax'), {
            speed: 0.5,
            videoSrc: 'https://www.youtube.com/watch?v=ab0TSkLe-E0'
        });
    }
}