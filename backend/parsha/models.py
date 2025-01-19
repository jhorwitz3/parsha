from django.db import models


class Summary(models.Model):
    title = models.CharField(max_length=200)
    summary = models.CharField(max_length=1500)
    pub_date = models.DateTimeField("date published")

    def __str__(self):
        return f'title: {self.title}, summary: {self.summary}, pub_date: {self.pub_date}'

