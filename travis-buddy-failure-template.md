## Travis Buddy
Hey **{{author}}**, 

It seems your pull-request has some errors.

Please read the following log in order to understand the failure reason. 

{{#jobs}}
### {{displayName}}
{{#scripts}}
<details>
  <summary>
    <strong>
     {{command}}
    </strong>
  </summary>

```
{{&contents}}
```
</details>
<br />
{{/scripts}}
{{/jobs}}
